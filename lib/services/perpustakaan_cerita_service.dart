import 'package:supabase_flutter/supabase_flutter.dart';

class PerpustakaanCeritaService {
  final _supabase = Supabase.instance.client;

  User? get currentUser => _supabase.auth.currentUser;

  /// Fetch all published stories with author details
  Future<List<Map<String, dynamic>>> getStories({
    String? category,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      var query = _supabase
          .from('perpustakaan_cerita')
          .select('*, profiles(display_name, avatar_url)');

      if (category != null && category != 'All') {
        query = query.eq('category', category);
      }

      // Filter only published stories if the column exists, otherwise assume all are public
      // query = query.eq('is_published', true);

      final data = await query
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print('Error fetching stories: $e');
      return [];
    }
  }

  /// Get single story by ID
  Future<Map<String, dynamic>?> getStory(String storyId) async {
    try {
      final data = await _supabase
          .from('perpustakaan_cerita')
          .select('*, profiles(display_name, avatar_url)')
          .eq('id', storyId)
          .single();

      return data;
    } catch (e) {
      print('Error fetching story: $e');
      return null;
    }
  }

  /// Create new story
  Future<String?> createStory({
    required String title,
    required String excerpt,
    required String content,
    required String category,
    required String readTime,
    String? coverImageUrl,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final response = await _supabase
          .from('perpustakaan_cerita')
          .insert({
            'author_id': userId,
            'title': title,
            'excerpt': excerpt,
            'content': content,
            'category': category,
            'read_time': readTime,
            'cover_image_url': coverImageUrl,
            'is_published': true,
          })
          .select()
          .single();

      return response['id'] as String;
    } catch (e) {
      print('Error creating story: $e');
      return null;
    }
  }

  /// Update story
  Future<void> updateStory({
    required String storyId,
    String? title,
    String? excerpt,
    String? content,
    String? category,
    String? readTime,
    String? coverImageUrl,
    bool? isPublished,
  }) async {
    try {
      final updates = <String, dynamic>{
        'updated_at': DateTime.now().toIso8601String(),
      };

      if (title != null) updates['title'] = title;
      if (excerpt != null) updates['excerpt'] = excerpt;
      if (content != null) updates['content'] = content;
      if (category != null) updates['category'] = category;
      if (readTime != null) updates['read_time'] = readTime;
      if (coverImageUrl != null) updates['cover_image_url'] = coverImageUrl;
      if (isPublished != null) updates['is_published'] = isPublished;

      await _supabase
          .from('perpustakaan_cerita')
          .update(updates)
          .eq('id', storyId);
    } catch (e) {
      print('Error updating story: $e');
      rethrow;
    }
  }

  /// Delete story
  Future<void> deleteStory(String storyId) async {
    try {
      await _supabase.from('perpustakaan_cerita').delete().eq('id', storyId);
    } catch (e) {
      print('Error deleting story: $e');
      rethrow;
    }
  }

  /// Like a story
  Future<void> likeStory(String storyId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await _supabase.from('perpustakaan_cerita_likes').insert({
        'story_id': storyId,
        'user_id': userId,
      });
    } catch (e) {
      print('Error liking story: $e');
      rethrow;
    }
  }

  /// Unlike a story
  Future<void> unlikeStory(String storyId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await _supabase
          .from('perpustakaan_cerita_likes')
          .delete()
          .eq('story_id', storyId)
          .eq('user_id', userId);
    } catch (e) {
      print('Error unliking story: $e');
      rethrow;
    }
  }

  /// Check if user has liked a story
  Future<bool> hasLikedStory(String storyId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return false;

      final data = await _supabase
          .from('perpustakaan_cerita_likes')
          .select()
          .eq('story_id', storyId)
          .eq('user_id', userId)
          .maybeSingle();

      return data != null;
    } catch (e) {
      print('Error checking like status: $e');
      return false;
    }
  }

  /// Get comments for a story
  Future<List<Map<String, dynamic>>> getComments(String storyId) async {
    try {
      // Need to join with profiles to get commenter details
      final data = await _supabase
          .from('perpustakaan_cerita_comments')
          .select('*, profiles(display_name, avatar_url)')
          .eq('story_id', storyId)
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print('Error fetching comments: $e');
      return [];
    }
  }

  /// Add comment to story
  Future<void> addComment({
    required String storyId,
    required String content,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await _supabase.from('perpustakaan_cerita_comments').insert({
        'story_id': storyId,
        'user_id': userId,
        'content': content,
      });
    } catch (e) {
      print('Error adding comment: $e');
      rethrow;
    }
  }

  /// Update comment
  Future<void> updateComment({
    required String commentId,
    required String content,
  }) async {
    try {
      await _supabase.from('perpustakaan_cerita_comments').update({
        'content': content,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', commentId);
    } catch (e) {
      print('Error updating comment: $e');
      rethrow;
    }
  }

  /// Delete comment
  Future<void> deleteComment(String commentId) async {
    try {
      await _supabase
          .from('perpustakaan_cerita_comments')
          .delete()
          .eq('id', commentId);
    } catch (e) {
      print('Error deleting comment: $e');
      rethrow;
    }
  }

  /// Get user's own stories
  Future<List<Map<String, dynamic>>> getMyStories() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return [];

      final data = await _supabase
          .from('perpustakaan_cerita')
          .select('*, profiles(display_name, avatar_url)')
          .eq('author_id', userId)
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print('Error fetching my stories: $e');
      return [];
    }
  }

  /// Bookmark a story
  Future<void> bookmarkStory(String storyId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await _supabase.from('perpustakaan_cerita_bookmarks').insert({
        'story_id': storyId,
        'user_id': userId,
      });
    } catch (e) {
      print('Error bookmarking story: $e');
      rethrow;
    }
  }

  /// Unbookmark a story
  Future<void> unbookmarkStory(String storyId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await _supabase
          .from('perpustakaan_cerita_bookmarks')
          .delete()
          .eq('story_id', storyId)
          .eq('user_id', userId);
    } catch (e) {
      print('Error unbookmarking story: $e');
      rethrow;
    }
  }

  /// Check if user has bookmarked a story
  Future<bool> hasBookmarkedStory(String storyId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return false;

      final data = await _supabase
          .from('perpustakaan_cerita_bookmarks')
          .select()
          .eq('story_id', storyId)
          .eq('user_id', userId)
          .maybeSingle();

      return data != null;
    } catch (e) {
      print('Error checking bookmark status: $e');
      return false;
    }
  }
}
