import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/home/home_header.dart';
import '../../widgets/home/daily_quote_card.dart';
import '../../widgets/home/mental_health_tips_card.dart';
import '../features/perpustakaan_cerita/perpustakaan_cerita_screen.dart';
import '../features/ruang_bercerita/ruang_bercerita_screen.dart';
import '../features/affirmation/affirmation_screen.dart';
import '../features/profile/profile_screen.dart';
import 'dart:math' as math;

// Konstanta untuk Background Asset
const String _BACKGROUND_ASSET = 'assets/maps_background.png';

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
      const RuangBerceritaScreen(),
      const AffirmationScreen(),
      const PerpustakaanCeritaScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Dibalik 180 Derajat
          Positioned.fill(
            child: Transform.rotate(
              angle: math.pi,
              child: Image.asset(
                _BACKGROUND_ASSET,
                fit: BoxFit.cover,
              ),
            ),
          ),

          _screens[_currentIndex],
        ],
      ),
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

// --- KONTEN BERANDA (Layout Stabil - Horizontal Actions) ---
class _HomeContent extends StatelessWidget {
  final Function(int) onTabChange;

  const _HomeContent({required this.onTabChange});

  // --- MODEL DATA UNTUK QUICK ACTIONS (Tidak berubah) ---
  final List<Map<String, dynamic>> quickActionsList = const [
    {'label': 'Bercerita', 'icon': Icons.forum, 'index': 1},
    {'label': 'Afirmasi', 'icon': Icons.favorite, 'index': 2},
    {'label': 'Cerita', 'icon': Icons.menu_book, 'index': 3},
    {'label': 'Profil', 'icon': Icons.person, 'index': 4},
  ];
  // -----------------------------------------------------------------

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.zero,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: const HomeHeader(),
      ),
    );
  }

  Widget _buildHorizontalActionItem(
    BuildContext context, {
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = screenWidth * 0.22;
    final double containerSize = screenWidth * 0.14;
    final double iconSize = screenWidth * 0.07;
    final double fontSize = screenWidth * 0.032;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: itemWidth,
        child: Column(
          children: [
            Container(
              width: containerSize,
              height: containerSize,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary, size: iconSize),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: fontSize, color: AppColors.textSecondary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double virtualHeaderHeight = 150.0;
    const double contentPadding = 20.0;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. STACK untuk HERO HEADER
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: virtualHeaderHeight,
                  color: AppColors.primary.withOpacity(0.05),
                ),
                Positioned(
                  top: virtualHeaderHeight - 80.0,
                  left: contentPadding,
                  right: contentPadding,
                  child: _buildHeroCard(context),
                ),
              ],
            ),

            // 2. KONTEN UTAMA SCROLLABLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: contentPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60.0),

                  // DailyQuoteCard (Swipeable)
                  _buildSectionTitle(context, 'Afirmasi Harian'),
                  const DailyQuoteCard(),

                  const SizedBox(height: 15),

                  // Aksi Cepat (HORIZONTAL LIST)
                  _buildSectionTitle(context, 'Aksi Cepat'),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.28,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      itemCount: quickActionsList.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 15),
                      itemBuilder: (context, index) {
                        final action = quickActionsList[index];
                        return _buildHorizontalActionItem(
                          context,
                          label: action['label'] as String,
                          icon: action['icon'] as IconData,
                          onTap: () => onTabChange(action['index'] as int),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // 4. MentalHealthTipsCard
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: contentPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(context, 'Tips Kesehatan Mental'),
                  const MentalHealthTipsCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
