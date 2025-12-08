import 'package:supabase_flutter/supabase_flutter.dart';

class RuangAfirmasiService {
  final _supabase = Supabase.instance.client;

  /// Get all ruang_afirmasi
  Future<List<Map<String, dynamic>>> getAffirmations({
    String? category,
  }) async {
    try {
      var query = _supabase.from('ruang_afirmasi').select();

      if (category != null && category != 'All') {
        query = query.eq('category', category);
      }

      final data = await query.order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print('Error fetching ruang_afirmasi: $e');
      return [];
    }
  }

  /// Get random affirmation
  Future<Map<String, dynamic>?> getRandomAffirmation() async {
    try {
      final ruangAfirmasi = await getAffirmations();
      if (ruangAfirmasi.isEmpty) return null;

      ruangAfirmasi.shuffle();
      return ruangAfirmasi.first;
    } catch (e) {
      print('Error fetching random affirmation: $e');
      return null;
    }
  }

  /// Save affirmation
  Future<void> saveAffirmation(String affirmationId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await _supabase.from('user_saved_ruang_afirmasi').insert({
        'user_id': userId,
        'affirmation_id': affirmationId,
      });
    } catch (e) {
      print('Error saving affirmation: $e');
      rethrow;
    }
  }

  /// Unsave affirmation
  Future<void> unsaveAffirmation(String affirmationId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await _supabase
          .from('user_saved_ruang_afirmasi')
          .delete()
          .eq('user_id', userId)
          .eq('affirmation_id', affirmationId);
    } catch (e) {
      print('Error unsaving affirmation: $e');
      rethrow;
    }
  }

  /// Check if affirmation is saved
  Future<bool> isAffirmationSaved(String affirmationId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return false;

      final data = await _supabase
          .from('user_saved_ruang_afirmasi')
          .select()
          .eq('user_id', userId)
          .eq('affirmation_id', affirmationId)
          .maybeSingle();

      return data != null;
    } catch (e) {
      print('Error checking saved status: $e');
      return false;
    }
  }

  /// Get saved affirmations
  Future<List<Map<String, dynamic>>> getSavedRuangAffirmasi() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return [];

      final data = await _supabase.from('user_saved_ruang_afirmasi').select('''
            *,
            ruang_afirmasi (
              id,
              content,
              created_at
            )
          ''').eq('user_id', userId).order('saved_at', ascending: false);

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print('Error fetching saved ruang_afirmasi: $e');
      return [];
    }
  }

  /// Get IDs of saved affirmations
  Future<Set<String>> getSavedAffirmationIds() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return {};

      final data = await _supabase
          .from('user_saved_ruang_afirmasi')
          .select('affirmation_id')
          .eq('user_id', userId);

      return Set<String>.from(
        data.map((item) => item['affirmation_id'] as String),
      );
    } catch (e) {
      print('Error fetching saved affirmation IDs: $e');
      return {};
    }
  }

  /// Create new affirmation (user-submitted)
  Future<bool> createAffirmation({
    required String content,
  }) async {
    try {
      await _supabase.from('ruang_afirmasi').insert({
        'content': content,
      });
      return true;
    } catch (e) {
      print('Error creating affirmation: $e');
      return false;
    }
  }
}
