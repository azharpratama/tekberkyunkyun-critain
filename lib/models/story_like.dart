// Model for story likes
// Matches the perpustakaan_cerita_likes table in Supabase schema
class StoryLike {
  final String id;
  final String storyId;
  final String userId;
  final DateTime createdAt;

  const StoryLike({
    required this.id,
    required this.storyId,
    required this.userId,
    required this.createdAt,
  });

  factory StoryLike.fromJson(Map<String, dynamic> json) {
    return StoryLike(
      id: json['id'] as String,
      storyId: json['story_id'] as String,
      userId: json['user_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'story_id': storyId,
      'user_id': userId,
    };
  }
}
