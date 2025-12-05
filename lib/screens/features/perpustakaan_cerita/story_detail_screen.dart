import 'package:flutter/material.dart';
import '../../../models/user_story.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class StoryDetailScreen extends StatelessWidget {
  final UserStory story;

  const StoryDetailScreen({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Semantic AppBar using SliverAppBar
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.9),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  child: IconButton(
                    icon: Icon(
                      story.isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color:
                          story.isBookmarked ? AppColors.primary : Colors.black,
                    ),
                    onPressed: () {
                      // Toggle bookmark
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  child: IconButton(
                    icon: const Icon(Icons.share, color: Colors.black),
                    onPressed: () {
                      // Share action
                    },
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: story.coverImage != null
                  ? Image.asset(
                      story.coverImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.primary.withOpacity(0.1),
                        child: const Center(
                          child: Icon(Icons.image,
                              size: 64, color: AppColors.primary),
                        ),
                      ),
                    )
                  : Container(
                      color: AppColors.primary.withOpacity(0.1),
                      child: const Center(
                        child: Icon(Icons.image,
                            size: 64, color: AppColors.primary),
                      ),
                    ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category & Date
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.accentBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          story.category,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.accentBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        story.date,
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.textSecondary),
                      ),
                      const Spacer(),
                      Text(
                        story.readTime,
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Title
                  Text(
                    story.title,
                    style: AppTextStyles.h2.copyWith(fontSize: 24, height: 1.3),
                  ),
                  const SizedBox(height: 24),

                  // Author Profile
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[300],
                        child: Text(story.authorName[0],
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            story.authorName,
                            style: AppTextStyles.bodyMedium
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Penulis',
                            style: AppTextStyles.bodySmall
                                .copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      const Spacer(),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          side: const BorderSide(color: AppColors.primary),
                        ),
                        child: const Text('Follow',
                            style: TextStyle(color: AppColors.primary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),

                  // Content
                  Text(
                    story.content,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 16,
                      height: 1.8,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Interaction Stats
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _InteractionItem(
                          icon: story.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          label: '${story.likesCount} Suka',
                          color: story.isLiked ? Colors.red : Colors.grey,
                        ),
                        _InteractionItem(
                          icon: Icons.mode_comment_outlined,
                          label: '${story.commentsCount} Komentar',
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, -4),
              blurRadius: 10,
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Tulis komentar...',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: AppColors.primary,
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white, size: 20),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InteractionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InteractionItem(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 8),
        Text(label,
            style: TextStyle(
                color: Colors.grey[600], fontWeight: FontWeight.w500)),
      ],
    );
  }
}
