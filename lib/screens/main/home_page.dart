import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/home/home_header.dart';
import '../../widgets/home/daily_quote_card.dart';
import '../../widgets/home/quick_actions_grid.dart';
import '../../widgets/home/mental_health_tips_card.dart';
import '../features/perpustakaan_cerita/perpustakaan_cerita_screen.dart';
import '../features/story/story_screen.dart';
import '../features/affirmation/affirmation_screen.dart';
import '../features/profile/profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      _HomeContent(
          onTabChange: (index) => setState(() => _currentIndex = index)),
      const StoryScreen(),
      const AffirmationScreen(),
      const PerpustakaanCeritaScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 8,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Bercerita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Afirmasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Cerita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class _HomeContent extends StatefulWidget {
  final Function(int) onTabChange;

  const _HomeContent({required this.onTabChange});

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animations = List.generate(4, (index) {
      final start = index * 0.1;
      final end = start + 0.5;
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end.clamp(0.0, 1.0), curve: Curves.easeOut),
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAnimatedItem(0, const HomeHeader()),
              const SizedBox(height: 24),
              _buildAnimatedItem(1, const DailyQuoteCard()),
              const SizedBox(height: 28),
              _buildAnimatedItem(
                  2, QuickActionsGrid(onTabChange: widget.onTabChange)),
              const SizedBox(height: 28),
              _buildAnimatedItem(3, const MentalHealthTipsCard()),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedItem(int index, Widget child) {
    return FadeTransition(
      opacity: _animations[index],
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(_animations[index]),
        child: child,
      ),
    );
  }
}
