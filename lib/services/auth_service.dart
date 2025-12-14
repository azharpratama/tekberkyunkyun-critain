import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final _supabase = Supabase.instance.client;

  /// Get current user
  User? get currentUser => _supabase.auth.currentUser;

  /// Check if user is authenticated
  bool get isAuthenticated => currentUser != null;

  /// Sign up with email and password
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'display_name': displayName,
      },
    );

    return response;
  }

  /// Sign in with email and password
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return response;
  }

  /// Sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  /// Get user profile from profiles table
  Future<Map<String, dynamic>?> getProfile() async {
    try {
      final userId = currentUser?.id;
      if (userId == null) return null;

      final data =
          await _supabase.from('profiles').select().eq('id', userId).single();

      return data;
    } catch (e) {
      debugPrint('Error fetching profile: $e');
      return null;
    }
  }

  /// Update user profile
  Future<void> updateProfile({
    String? displayName,
    String? avatarUrl,
    String? bio,
  }) async {
    try {
      final userId = currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final updates = <String, dynamic>{
        'updated_at': DateTime.now().toIso8601String(),
      };

      if (displayName != null) updates['display_name'] = displayName;
      if (avatarUrl != null) updates['avatar_url'] = avatarUrl;
      if (bio != null) updates['bio'] = bio;

      await _supabase.from('profiles').update(updates).eq('id', userId);
    } catch (e) {
      debugPrint('Error updating profile: $e');
      rethrow;
    }
  }

  /// Update user stats (points, badges, etc.)
  Future<void> updateStats({
    int? totalPoints,
    String? badgeLevel,
    int? listeningSessionsCompleted,
    int? speakingSessionsCompleted,
    int? peopleHelped,
  }) async {
    try {
      final userId = currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final updates = <String, dynamic>{};

      if (totalPoints != null) updates['total_points'] = totalPoints;
      if (badgeLevel != null) updates['badge_level'] = badgeLevel;
      if (listeningSessionsCompleted != null) {
        updates['listening_sessions_completed'] = listeningSessionsCompleted;
      }
      if (speakingSessionsCompleted != null) {
        updates['speaking_sessions_completed'] = speakingSessionsCompleted;
      }
      if (peopleHelped != null) updates['people_helped'] = peopleHelped;

      await _supabase.from('profiles').update(updates).eq('id', userId);
    } catch (e) {
      debugPrint('Error updating stats: $e');
      rethrow;
    }
  }

  /// Listen to auth state changes
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  /// Reset password
  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }
}
