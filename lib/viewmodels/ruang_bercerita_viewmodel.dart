import 'dart:async';
import 'package:flutter/material.dart';
import '../models/message.dart';
import '../services/ruang_bercerita_service.dart';
import '../models/user_stats.dart';

class RuangBerceritaViewModel extends ChangeNotifier {
  final RuangBerceritaService _service = RuangBerceritaService();

  // State
  int _currentStep = 0; // 0 = Intro, 1 = Searching/Waiting, 2 = Chat
  bool _isInSession = false;
  bool _isSpeakerMode = true; // true = Speaker, false = Listener
  String? _sessionId;
  StreamSubscription? _queueSubscription;
  StreamSubscription? _messageSubscription;
  StreamSubscription? _sessionSubscription;
  String? _errorMessage;

  // Getters
  int get currentStep => _currentStep;
  bool get isInSession => _isInSession;
  bool get isSpeakerMode => _isSpeakerMode;
  String? get sessionId => _sessionId;
  String? get errorMessage => _errorMessage;

  // Chat State
  final List<Message> _messages = [];
  bool _isPartnerTyping =
      false; // We might need a realtime typing indicator later

  List<Message> get messages => _messages;
  bool get isPartnerTyping => _isPartnerTyping;

  // Actions
  void setMode(bool isSpeaker) {
    _isSpeakerMode = isSpeaker;
    _currentStep = 0; // Reset step when switching modes
    _messages.clear(); // Clear messages
    notifyListeners();
  }

  Future<void> startSession() async {
    try {
      _errorMessage = null;
      _currentStep = 1; // Waiting/Searching
      _isInSession = true;
      notifyListeners();

      // 1. Join the queue
      await _service.joinQueue(isSpeaker: _isSpeakerMode);

      // 2. Try to match immediately (Active)
      final match = await _service.attemptMatch();
      if (match != null) {
        // Matched immediately!
        _handleSessionStart(match['session_id'] as String);
        return;
      }

      // 3. If no immediate match, listen to queue status (Passive)
      _listenToQueue();
    } catch (e) {
      _errorMessage = 'Gagal memulai sesi: $e';
      _currentStep = 0;
      _isInSession = false;
      notifyListeners();
    }
  }

  void _listenToQueue() {
    _queueSubscription?.cancel();
    _queueSubscription = _service.streamQueueStatus().listen((queueData) {
      if (queueData.isNotEmpty) {
        final status = queueData.first['status'] as String;
        if (status == 'matched') {
          // We got matched by someone else!
          _checkForActiveSession();
        }
      }
    });
  }

  Future<void> _checkForActiveSession() async {
    try {
      // Small delay to ensure DB propagation
      await Future.delayed(const Duration(milliseconds: 500));
      final session = await _service.getActiveSession();
      if (session != null) {
        _handleSessionStart(session['id'] as String);
      }
    } catch (e) {
      print('Error checking session: $e');
    }
  }

  void _handleSessionStart(String sessionId) {
    _queueSubscription?.cancel(); // Stop listening to queue
    _sessionId = sessionId;
    _currentStep = 2; // Chat Interface
    _messages.clear();

    // Subscribe to messages
    _subscribeToMessages();

    // Subscribe to session status
    _subscribeToSessionStatus();

    notifyListeners();
  }

  void _subscribeToSessionStatus() {
    if (_sessionId == null) return;

    _sessionSubscription?.cancel();
    _sessionSubscription = _service.streamSession(_sessionId!).listen((data) {
      if (data.isNotEmpty) {
        final status = data['status'] as String?;
        if (status == 'ended') {
          // Partner ended the session
          _handlePartnerEndedSession();
        }
      }
    });
  }

  void _handlePartnerEndedSession() {
    if (!_isInSession || _sessionId == null) return;

    _cleanupSessionState();
    _errorMessage = 'Teman bercerita telah mengakhiri sesi.';
    notifyListeners();
  }

  void _subscribeToMessages() {
    if (_sessionId == null) return;

    _messageSubscription?.cancel();
    _messageSubscription = _service.streamMessages(_sessionId!).listen((data) {
      // Map Supabase data to Message model
      // Note: We need to know current user ID to determine isUser
      // Since service handles auth, we assume sender_id match check happens there or strictly here
      // For simplicity, we fetch messages and re-map.
      // But `Message` model relies on `isUser` boolean.
      // We calculate `isUser` by comparing with current user ID from Supabase Auth.

      final currentUserId = _service.currentUserId;

      _messages.clear();
      for (var item in data) {
        final isMe = item['sender_id'] == currentUserId;
        _messages.add(Message(
          id: item['id'] as String,
          text: item['content'] as String,
          isUser: isMe,
          timestamp: DateTime.parse(item['created_at'] as String).toLocal(),
        ));
      }
      notifyListeners();
    });
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty || _sessionId == null) return;

    try {
      // Optimistic update not strictly needed with realtime, but feels faster
      // _messages.add(Message(
      //   id: 'temp',
      //   text: text,
      //   isUser: true,
      //   timestamp: DateTime.now(),
      // ));
      // notifyListeners();

      await _service.sendMessage(sessionId: _sessionId!, content: text.trim());
    } catch (e) {
      print('Error sending message: $e');
      // Handle error (maybe remove optimistic message)
    }
  }

  Future<void> endSession() async {
    if (_sessionId != null) {
      try {
        await _service.endSession(sessionId: _sessionId!);
      } catch (e) {
        print('Error ending session: $e');
      }
    }

    _cleanupSessionState(awardPoints: true);
  }

  void _cleanupSessionState({bool awardPoints = false}) {
    // Cleanup subscriptions
    _queueSubscription?.cancel();
    _messageSubscription?.cancel();
    _sessionSubscription?.cancel();
    _sessionId = null;

    // Award points
    if (awardPoints || true) {
      // Always award points for participation
      if (_isSpeakerMode) {
        UserStatsService.completeSpeakingSession();
      } else {
        UserStatsService.completeListeningSession();
      }
    }

    _isInSession = false;
    _currentStep = 0;
    _messages.clear();
    notifyListeners();
  }

  // Helper to get reward points based on mode
  int get rewardPoints => _isSpeakerMode ? 5 : 10;

  @override
  void dispose() {
    _queueSubscription?.cancel();
    _messageSubscription?.cancel();
    _sessionSubscription?.cancel();
    super.dispose();
  }
}
