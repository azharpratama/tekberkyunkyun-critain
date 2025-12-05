import 'package:flutter/material.dart';
import '../../../models/user_story.dart';
import '../../../data/stories_data.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/explore/story_card.dart';
import 'write_story_screen.dart';

class PerpustakaanCeritaScreen extends StatefulWidget {
  const PerpustakaanCeritaScreen({super.key});

  @override
  State<PerpustakaanCeritaScreen> createState() =>
      _PerpustakaanCeritaScreenState();
}

class _PerpustakaanCeritaScreenState extends State<PerpustakaanCeritaScreen>
    with SingleTickerProviderStateMixin {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Kesehatan Mental',
    'Personal Story',
    'Wellness',
    'Work',
    'Relationships'
  ];

  late AnimationController _fabController;
  late Animation<double> _fabScaleAnimation;
  late Animation<double> _fabPulseAnimation;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _fabScaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _fabController,
        curve: Curves.easeInOut,
      ),
    );

    _fabPulseAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(
        parent: _fabController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  List<UserStory> get _filteredStories {
    if (_selectedCategory == 'All') return userStories;
    return userStories.where((s) => s.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Gradient Header
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.8),
                    AppColors.accentBlue,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title with icon
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.auto_stories_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Perpustakaan Cerita',
                                  style: AppTextStyles.h2.copyWith(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${_filteredStories.length} cerita inspiratif',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Search bar (placeholder)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search_rounded,
                              color: Colors.grey[400],
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Cari cerita...',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Category Filter
                      SizedBox(
                        height: 42,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: _categories.length,
                          itemBuilder: (context, index) {
                            final category = _categories[index];
                            final isSelected = _selectedCategory == category;
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: _buildCategoryChip(category, isSelected),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Story List
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
            sliver: _filteredStories.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 60),
                          Icon(
                            Icons.auto_stories_outlined,
                            size: 80,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Belum ada cerita',
                            style: AppTextStyles.h3.copyWith(
                              color: Colors.grey[400],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Jadilah yang pertama berbagi cerita!',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final story = _filteredStories[index];
                        return StoryCard(
                          story: story,
                          index: index,
                        );
                      },
                      childCount: _filteredStories.length,
                    ),
                  ),
          ),
        ],
      ),

      // Animated Floating Action Button
      floatingActionButton: AnimatedBuilder(
        animation: _fabController,
        builder: (context, child) {
          return Transform.scale(
            scale: _fabScaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: _fabPulseAnimation.value + 15,
                    spreadRadius: _fabPulseAnimation.value / 2,
                  ),
                ],
              ),
              child: FloatingActionButton.extended(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const WriteStoryScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 1),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          )),
                          child: child,
                        );
                      },
                    ),
                  );

                  if (result == true && mounted) {
                    setState(() {});
                  }
                },
                backgroundColor: AppColors.primary,
                elevation: 8,
                icon: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit_rounded,
                    color: Colors.white,
                  ),
                ),
                label: const Text(
                  'Tulis Cerita',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryChip(String category, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0.95),
                  ],
                )
              : null,
          color: isSelected ? null : Colors.white.withOpacity(0.25),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? AppColors.primary : Colors.white,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
