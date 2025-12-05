import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../models/user_story.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class StoryDetailScreen extends StatefulWidget {
  final UserStory story;

  const StoryDetailScreen({super.key, required this.story});

  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isLiked = false;
  bool _isBookmarked = false;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isLiked = widget.story.isLiked;
    _isBookmarked = widget.story.isBookmarked;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
    // TODO: Supabase integration
  }

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    // TODO: Supabase integration
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Glassmorphism AppBar with Hero Image
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildGlassButton(
                child:
                    const Icon(Icons.arrow_back_rounded, color: Colors.white),
                onTap: () => Navigator.pop(context),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildGlassButton(
                  child: Icon(
                    _isBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_border_rounded,
                    color: Colors.white,
                  ),
                  onTap: _toggleBookmark,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
                child: _buildGlassButton(
                  child: const Icon(Icons.share_rounded, color: Colors.white),
                  onTap: () {
                    // Share functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fitur share coming soon!')),
                    );
                  },
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Hero Image
                  widget.story.coverImage != null
                      ? Image.asset(
                          widget.story.coverImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildPlaceholderImage(),
                        )
                      : _buildPlaceholderImage(),

                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.transparent,
                          Colors.white,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category & Metadata
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primary.withOpacity(0.15),
                                  AppColors.accentBlue.withOpacity(0.15),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              widget.story.category,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.access_time_rounded,
                            size: 16,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.story.readTime,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            widget.story.date,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Title
                      Text(
                        widget.story.title,
                        style: AppTextStyles.h2.copyWith(
                          fontSize: 28,
                          height: 1.3,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey[900],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Author Profile Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey[50]!,
                              Colors.white,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.grey[200]!,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primary,
                                    AppColors.accentBlue,
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.all(2.5),
                              child: CircleAvatar(
                                radius: 26,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.grey[100],
                                  child: Text(
                                    widget.story.authorName[0].toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.story.authorName,
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Penulis',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Follow button (placeholder)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primary,
                                    AppColors.accentBlue,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Text(
                                'Follow',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Content
                      Text(
                        widget.story.content,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 17,
                          height: 1.8,
                          color: Colors.grey[800],
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Interaction Stats Divider
                      Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.grey[300]!,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Interaction Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildInteractionButton(
                            icon: _isLiked
                                ? Icons.favorite
                                : Icons.favorite_border_rounded,
                            label: '${widget.story.likesCount} Suka',
                            color: _isLiked ? Colors.red : AppColors.primary,
                            onTap: _toggleLike,
                          ),
                          _buildInteractionButton(
                            icon: Icons.chat_bubble_outline_rounded,
                            label: '${widget.story.commentsCount} Komentar',
                            color: AppColors.accentBlue,
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.grey[300]!,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Comments Section Header
                      Row(
                        children: [
                          const Icon(
                            Icons.chat_bubble_rounded,
                            color: AppColors.primary,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Komentar',
                            style: AppTextStyles.h3.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Placeholder for comments
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Column(
                            children: [
                              Icon(
                                Icons.chat_bubble_outline_rounded,
                                size: 60,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Belum ada komentar',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Jadilah yang pertama berkomentar!',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // Comment Input Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, -4),
              blurRadius: 20,
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.grey[300]!,
                    ),
                  ),
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Tulis komentar...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.accentBlue,
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.send_rounded, color: Colors.white),
                  onPressed: () {
                    // TODO: Add comment
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fitur komentar akan segera hadir!'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.3),
            AppColors.accentBlue.withOpacity(0.3),
          ],
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.auto_stories_rounded,
          size: 80,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildGlassButton({
    required Widget child,
    required VoidCallback onTap,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(16),
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
