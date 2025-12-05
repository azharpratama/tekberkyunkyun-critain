import 'package:flutter/material.dart';
import '../../../models/user_story.dart';
import '../../../data/stories_data.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/explore/story_card.dart';

class PerpustakaanCeritaScreen extends StatefulWidget {
  const PerpustakaanCeritaScreen({super.key});

  @override
  State<PerpustakaanCeritaScreen> createState() =>
      _PerpustakaanCeritaScreenState();
}

class _PerpustakaanCeritaScreenState extends State<PerpustakaanCeritaScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Kesehatan Mental',
    'Personal Story',
    'Wellness',
    'Work',
    'Relationships'
  ];

  List<UserStory> get _filteredStories {
    if (_selectedCategory == 'All') return userStories;
    return userStories.where((s) => s.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 24, bottom: 16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Perpustakaan Cerita',
                    style: AppTextStyles.h2,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Temukan cerita inspiratif dari komunitas kami.',
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 24),

                  // Category Filter
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _categories.map((category) {
                        final isSelected = _selectedCategory == category;
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: FilterChip(
                            label: Text(category),
                            selected: isSelected,
                            onSelected: (bool selected) {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            backgroundColor: Colors.white,
                            selectedColor: AppColors.primary.withOpacity(0.1),
                            checkmarkColor: AppColors.primary,
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.grey[300]!,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Story List
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final story = _filteredStories[index];
                  return StoryCard(story: story);
                },
                childCount: _filteredStories.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Implement create story
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Fitur tulis cerita akan segera hadir!')),
          );
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.edit),
        label: const Text('Tulis Cerita'),
      ),
    );
  }
}
