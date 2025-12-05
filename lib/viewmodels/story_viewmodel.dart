import 'package:flutter/material.dart';
import '../models/user_stats.dart';
import '../models/message.dart';

class StoryViewModel extends ChangeNotifier {
  // State
  int _currentStep = 0; // 0 = Intro, 1 = Searching/Waiting, 2 = Chat
  bool _isInSession = false;
  bool _isSpeakerMode = true; // true = Speaker, false = Listener

  // Getters
  int get currentStep => _currentStep;
  bool get isInSession => _isInSession;
  bool get isSpeakerMode => _isSpeakerMode;

  // Chat State
  final List<Message> _messages = [];
  bool _isPartnerTyping = false;

  List<Message> get messages => _messages;
  bool get isPartnerTyping => _isPartnerTyping;

  // Actions
  void setMode(bool isSpeaker) {
    _isSpeakerMode = isSpeaker;
    _currentStep = 0; // Reset step when switching modes
    _messages.clear(); // Clear messages
    notifyListeners();
  }

  void startSession() {
    _currentStep = 1; // Searching/Waiting
    _isInSession = true;
    notifyListeners();

    // Mock connection delay
    Future.delayed(const Duration(seconds: 3), () {
      _currentStep = 2; // Connected
      _addInitialMessage();
      notifyListeners();
    });
  }

  void _addInitialMessage() {
    final text = _isSpeakerMode
        ? 'Halo! Saya di sini untuk mendengarkanmu. Silakan ceritakan apa saja yang ingin kamu sampaikan. 🌿'
        : 'Halo... aku lagi sedih banget hari ini.';

    // Simulate partner typing first
    _isPartnerTyping = true;
    notifyListeners();

    Future.delayed(const Duration(seconds: 2), () {
      _isPartnerTyping = false;
      _messages.add(Message(
        id: DateTime.now().toString(),
        text: text,
        isUser: false,
        timestamp: DateTime.now(),
      ));
      notifyListeners();
    });
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    // Add user message
    _messages.add(Message(
      id: DateTime.now().toString(),
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    ));
    notifyListeners();

    // Simulate partner response
    _simulatePartnerResponse();
  }

  void _simulatePartnerResponse() {
    // 1. Delay before typing
    Future.delayed(const Duration(seconds: 1), () {
      _isPartnerTyping = true;
      notifyListeners();

      // 2. Typing duration
      Future.delayed(const Duration(seconds: 2), () {
        _isPartnerTyping = false;

        final responses = _isSpeakerMode
            ? [
                // Responses when user is Speaker (Partner is Listener)
                'Terima kasih sudah mau berbagi. Aku mendengarkan. 💚',
                'Itu pasti tidak mudah bagimu. Aku di sini untukmu.',
                'Kamu tidak sendirian dalam hal ini.',
                'Pelan-pelan saja ceritanya, aku siap mendengarkan.',
              ]
            : [
                // Responses when user is Listener (Partner is Speaker)
                'Iya, rasanya berat sekali.',
                'Terima kasih sudah mendengarkan.',
                'Aku merasa sedikit lebih lega sekarang.',
                'Senang ada yang mau mengerti.',
              ];

        _messages.add(Message(
          id: DateTime.now().toString(),
          text: responses[DateTime.now().second % responses.length],
          isUser: false,
          timestamp: DateTime.now(),
        ));
        notifyListeners();
      });
    });
  }

  void endSession() {
    if (_isSpeakerMode) {
      UserStatsService.completeSpeakingSession();
    } else {
      UserStatsService.completeListeningSession();
    }

    _isInSession = false;
    _currentStep = 0;
    _messages.clear();
    notifyListeners();
  }

  // Helper to get reward points based on mode
  int get rewardPoints => _isSpeakerMode ? 5 : 10;
}
