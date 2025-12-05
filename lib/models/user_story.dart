class UserStory {
  final String id;
  final String title;
  final String excerpt;
  final String content;
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
}
