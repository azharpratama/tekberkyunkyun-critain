import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

class RuangBerceritaService {
  final _supabase = Supabase.instance.client;

  /// Join matchmaking queue
  Future<void> joinQueue({required bool isSpeaker}) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await _supabase.from('ruang_bercerita_queue').insert({
        'user_id': userId,
        'mode': isSpeaker ? 'speaker' : 'listener',
        'status': 'waiting',
      });
    } catch (e) {
      debugPrint('Error joining queue: $e');
      rethrow;
    }
  }

  /// Leave matchmaking queue
  Future<void> leaveQueue() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      await _supabase
          .from('ruang_bercerita_queue')
          .delete()
          .eq('user_id', userId);
    } catch (e) {
      debugPrint('Error leaving queue: $e');
    }
  }

  /// Check if user is in queue
  Future<Map<String, dynamic>?> checkQueueStatus() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return null;

      final data = await _supabase
          .from('ruang_bercerita_queue')
          .select()
          .eq('user_id', userId)
          .maybeSingle();

      return data;
    } catch (e) {
      debugPrint('Error checking queue: $e');
      return null;
    }
  }

  /// Attempt to match users (call this periodically or via Edge Function)
  Future<Map<String, dynamic>?> attemptMatch() async {
    try {
      final result = await _supabase.rpc('match_users').maybeSingle();
      return result;
    } catch (e) {
      debugPrint('Error matching users: $e');
      return null;
    }
  }

  /// Get active session for current user
  Future<Map<String, dynamic>?> getActiveSession() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return null;

      final data = await _supabase
          .from('ruang_bercerita_sessions')
          .select()
          .or('speaker_id.eq.$userId,listener_id.eq.$userId')
          .eq('status', 'active')
          .maybeSingle();

      return data;
    } catch (e) {
      debugPrint('Error fetching active session: $e');
      return null;
    }
  }

  /// Send message in chat session
  Future<void> sendMessage({
    required String sessionId,
    required String content,
    bool isSystemMessage = false,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await _supabase.from('ruang_bercerita_messages').insert({
        'session_id': sessionId,
        'sender_id': userId,
        'content': content,
        'is_system_message': isSystemMessage,
      });
    } catch (e) {
      debugPrint('Error sending message: $e');
      rethrow;
    }
  }

  /// Get messages for a session
  Future<List<Map<String, dynamic>>> getMessages(String sessionId) async {
    try {
      final data = await _supabase
          .from('ruang_bercerita_messages')
          .select()
          .eq('session_id', sessionId)
          .order('created_at', ascending: true);

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      debugPrint('Error fetching messages: $e');
      return [];
    }
  }

  /// Subscribe to real-time messages for a session
  Stream<List<Map<String, dynamic>>> streamMessages(String sessionId) {
    return _supabase
        .from('ruang_bercerita_messages')
        .stream(primaryKey: ['id'])
        .eq('session_id', sessionId)
        .order('created_at');
  }

  /// End chat session
  Future<void> endSession({
    required String sessionId,
    int? rating,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      // Fetch session to determine if user is speaker or listener
      final session = await _supabase
          .from('ruang_bercerita_sessions')
          .select()
          .eq('id', sessionId)
          .single();

      final isSpeaker = session['speaker_id'] == userId;

      final updates = <String, dynamic>{
        'status': 'ended',
        'ended_at': DateTime.now().toIso8601String(),
      };

      if (rating != null) {
        if (isSpeaker) {
          updates['speaker_rating'] = rating;
        } else {
          updates['listener_rating'] = rating;
        }
      }

      await _supabase
          .from('ruang_bercerita_sessions')
          .update(updates)
          .eq('id', sessionId);
    } catch (e) {
      debugPrint('Error ending session: $e');
      rethrow;
    }
  }

  /// Subscribe to queue status changes (for matchmaking notifications)
  Stream<List<Map<String, dynamic>>> streamQueueStatus() {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      return Stream.value([]);
    }

    return _supabase
        .from('ruang_bercerita_queue')
        .stream(primaryKey: ['id']).eq('user_id', userId);
  }
}
