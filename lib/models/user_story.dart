class UserStory {
  final String id;
  final String title;
  final String excerpt;
  final String content;
  final String authorId;
  final String authorName;
  final String authorAvatar;
  final String date;
  final String? coverImage;
  final String category;
  final String readTime;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;
  final bool isBookmarked;

  const UserStory({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.authorAvatar,
    required this.date,
    this.coverImage,
    required this.category,
    required this.readTime,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.isLiked = false,
    this.isBookmarked = false,
  });

  UserStory copyWith({
    String? id,
    String? title,
    String? excerpt,
    String? content,
    String? authorId,
    String? authorName,
    String? authorAvatar,
    String? date,
    String? coverImage,
    String? category,
    String? readTime,
    int? likesCount,
    int? commentsCount,
    bool? isLiked,
    bool? isBookmarked,
  }) {
    return UserStory(
      id: id ?? this.id,
      title: title ?? this.title,
      excerpt: excerpt ?? this.excerpt,
      content: content ?? this.content,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      date: date ?? this.date,
      coverImage: coverImage ?? this.coverImage,
      category: category ?? this.category,
      readTime: readTime ?? this.readTime,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      isLiked: isLiked ?? this.isLiked,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }

  factory UserStory.fromJson(Map<String, dynamic> json) {
    // Handle potential nested profile data from join
    final profile = json['profiles'] as Map<String, dynamic>?;

    // Helper function to format date
    String formatDate(DateTime dateTime) {
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 7) {
        return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} days ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hours ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minutes ago';
      } else {
        return 'Just now';
      }
    }

    return UserStory(
      id: json['id'] as String,
      title: json['title'] as String,
      excerpt: json['excerpt'] as String? ?? '',
      content: json['content'] as String,
      authorId: json['author_id'] as String? ?? '',
      authorName: profile?['display_name'] as String? ??
          json['author_name'] as String? ??
          'Anonymous',
      authorAvatar: profile?['avatar_url'] as String? ??
          json['author_avatar'] as String? ??
          'assets/avatars/default.png',
      date: json['created_at'] != null
          ? formatDate(DateTime.parse(json['created_at'] as String))
          : 'Just now',
      coverImage: json['cover_image_url'] as String?,
      category: json['category'] as String? ?? 'General',
      readTime: json['read_time'] as String? ?? '3 min read',
      likesCount: json['likes_count'] as int? ?? 0,
      commentsCount: json['comments_count'] as int? ?? 0,
      isLiked: json['is_liked'] as bool? ?? false,
      isBookmarked: json['is_bookmarked'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'excerpt': excerpt,
      'content': content,
      'author_name': authorName,
      'author_avatar': authorAvatar,
      'created_at': date,
      'cover_image_url': coverImage,
      'category': category,
      'read_time': readTime,
      'likes_count': likesCount,
      'comments_count': commentsCount,
      'is_liked': isLiked,
      'is_bookmarked': isBookmarked,
    };
  }
}
