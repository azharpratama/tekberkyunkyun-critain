import 'package:flutter/material.dart';
import '../../models/user_story.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../screens/features/perpustakaan_cerita/story_detail_screen.dart';

class StoryCard extends StatelessWidget {
  final UserStory story;

  const StoryCard({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoryDetailScreen(story: story),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image (if exists)
              if (story.coverImage != null)
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey[200], // Placeholder color
                    child: Image.asset(
                      story.coverImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.primary.withOpacity(0.1),
                        child: const Center(
                          child: Icon(Icons.image, color: AppColors.primary),
                        ),
                      ),
                    ),
                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category & Read Time
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.accentBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            story.category,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.accentBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          story.readTime,
                          style: AppTextStyles.bodySmall
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Title
                    Text(
                      story.title,
                      style: AppTextStyles.h3.copyWith(fontSize: 18),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Excerpt
                    Text(
                      story.excerpt,
                      style: AppTextStyles.bodyMedium
                          .copyWith(color: AppColors.textSecondary),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),

                    // Footer: Author & Interactions
                    Row(
                      children: [
                        // Author
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey[300],
                          child: Text(story.authorName[0],
                              style: const TextStyle(fontSize: 10)),
                          // backgroundImage: AssetImage(story.authorAvatar), // Use asset if available
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            story.authorName,
                            style: AppTextStyles.bodySmall
                                .copyWith(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // Interactions
                        Row(
                          children: [
                            Icon(
                              story.isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 18,
                              color: story.isLiked ? Colors.red : Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text('${story.likesCount}',
                                style: AppTextStyles.bodySmall),
                            const SizedBox(width: 16),
                            const Icon(Icons.mode_comment_outlined,
                                size: 18, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text('${story.commentsCount}',
                                style: AppTextStyles.bodySmall),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
