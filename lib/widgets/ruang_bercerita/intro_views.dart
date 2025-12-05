import 'package:flutter/material.dart';
import '../../models/user_stats.dart';

class IntroView extends StatelessWidget {
  final VoidCallback onStart;

  const IntroView({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A9D76).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.forum_outlined,
                    size: 40,
                    color: Color(0xFF3A9D76),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Ceritakan Keluh Kesahmu',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Di sini, kamu bisa berbagi cerita dengan pendengar anonim yang peduli. Identitasmu terlindungi, tanpa penilaian.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15, color: Colors.grey[700], height: 1.5),
                ),
                const SizedBox(height: 32),
                _buildRuleCard(Icons.visibility_off, 'Anonim',
                    'Identitasmu tidak akan diketahui pendengar.'),
                const SizedBox(height: 12),
                _buildRuleCard(Icons.lock_outline, 'Aman',
                    'Setiap percakapan dijaga kerahasiaannya.'),
                const SizedBox(height: 12),
                _buildRuleCard(Icons.favorite_border, 'Tanpa Penghakiman',
                    'Ruang untuk berbicara dengan bebas.'),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        // Fixed button at bottom
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onStart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A9D76),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Mulai Bercerita',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRuleCard(IconData icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF3A9D76).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF3A9D76)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
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

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A9D76).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.hearing,
                    size: 40,
                    color: Color(0xFF3A9D76),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Jadi Pendengar yang Baik',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Bantu orang lain dengan mendengarkan cerita mereka. Kamu akan mendapatkan reward dan membuat perbedaan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15, color: Colors.grey[700], height: 1.5),
                ),
                const SizedBox(height: 32),
                _buildBenefitCard('🎁', 'Dapatkan Reward',
                    '+10 poin per sesi\nBadge: Bronze → Gold'),
                const SizedBox(height: 12),
                _buildBenefitCard(
                    '🩺', '1 Sesi Gratis Pro', 'Setiap 10 sesi mendengarmu'),
                const SizedBox(height: 12),
                _buildBenefitCard('💚', 'Buat Perbedaan',
                    'Kamu sudah membantu ${stats.peopleHelped} orang'),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        // Fixed button at bottom
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onStart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A9D76),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Mulai Mendengar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitCard(String emoji, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 32)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
