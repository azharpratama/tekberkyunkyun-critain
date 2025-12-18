import 'package:flutter/material.dart';
import '../../models/user_stats.dart';

class IntroView extends StatelessWidget {
  final VoidCallback onStart;

  const IntroView({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    // Primary Green color (extracted for consistency)
    const primaryGreen = Color(0xFF3A9D76);

    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    // Hero Section
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: primaryGreen.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.forum_outlined,
                        size: 48,
                        color: primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Ceritakan Keluh Kesahmu',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    // Constrained width 80%
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: Text(
                        'Di sini, kamu bisa berbagi cerita dengan pendengar anonim yang peduli. Identitasmu terlindungi, tanpa penilaian.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey[600], height: 1.5),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Trust Cards
                    _buildRuleCard(
                        Icons.visibility_off,
                        'Anonim',
                        'Identitasmu tidak akan diketahui pendengar.',
                        primaryGreen),
                    const SizedBox(height: 16),
                    _buildRuleCard(
                        Icons.lock_outline,
                        'Aman',
                        'Setiap percakapan dijaga kerahasiaannya.',
                        primaryGreen),
                    const SizedBox(height: 16),
                    _buildRuleCard(Icons.favorite_border, 'Tanpa Penghakiman',
                        'Ruang untuk berbicara dengan bebas.', primaryGreen),
                    const SizedBox(height: 100), // Height for floating button
                  ],
                ),
              ),
            ),
          ],
        ),
        // CTA Button pinned to bottom
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: onStart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: primaryGreen.withValues(alpha: 0.4),
                    shape: const StadiumBorder(),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Mulai Bercerita'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRuleCard(
      IconData icon, String title, String description, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: primaryColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListenerIntroView extends StatelessWidget {
  final VoidCallback onStart;

  const ListenerIntroView({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    final stats = UserStatsService.currentStats;
    const primaryGreen = Color(0xFF3A9D76);

    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: primaryGreen.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.hearing,
                        size: 48,
                        color: primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Jadi Pendengar yang Baik',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: Text(
                        'Bantu orang lain dengan mendengarkan cerita mereka. Kamu akan mendapatkan reward dan membuat perbedaan.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey[600], height: 1.5),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildBenefitCard(
                        '🎁',
                        'Dapatkan Reward',
                        '+10 poin per sesi\nBadge: Bronze → Gold',
                        primaryGreen),
                    const SizedBox(height: 16),
                    _buildBenefitCard('🩺', '1 Sesi Gratis Pro',
                        'Setiap 10 sesi mendengarmu', primaryGreen),
                    const SizedBox(height: 16),
                    _buildBenefitCard(
                        '💚',
                        'Buat Perbedaan',
                        'Kamu sudah membantu ${stats.peopleHelped} orang',
                        primaryGreen),
                    const SizedBox(height: 100), // Height for floating button
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: onStart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: primaryGreen.withValues(alpha: 0.4),
                    shape: const StadiumBorder(),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Mulai Mendengar'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitCard(
      String emoji, String title, String description, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
