import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../viewmodels/profile_viewmodel.dart';
import '../professional/subscription_screen.dart';
import '../professional/consultation_screen.dart';
import '../affirmation/saved_affirmations_screen.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProfileContent();
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();
    final stats = vm.stats;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: (Navigator.canPop(context)
            ? IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: () => Navigator.pop(context),
              )
            : null),
        automaticallyImplyLeading: false,
        title: Text(
          'Profil Saya',
          style: AppTextStyles.h2,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.textPrimary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          // Profile Header
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: vm.profileImage,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      vm.username,
                      style: AppTextStyles.h1,
                    ),
                    if (stats.badgeLevel != 'none') ...[
                      const SizedBox(width: 8),
                      Text(
                        stats.getBadgeEmoji(),
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Member sejak 2025',
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Stats Cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: _StatsCard(
                    value: stats.totalPoints.toString(),
                    label: 'Poin',
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryDark],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatsCard(
                    value: stats.peopleHelped.toString(),
                    label: 'Orang Dibantu',
                    gradient: const LinearGradient(
                      colors: [AppColors.secondary, AppColors.secondaryDark],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Settings List
          _buildSettingItem(
            icon: Icons.card_giftcard,
            title: 'Paket Langganan',
            color: AppColors.success,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SubscriptionScreen(),
                ),
              );
            },
          ),
          _buildSettingItem(
            icon: Icons.psychology,
            title: 'Konsultasi Profesional',
            color: AppColors.secondary,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ConsultationScreen()),
              );
            },
          ),
          _buildSettingItem(
            icon: Icons.favorite,
            title: 'Koleksi Afirmasi',
            color: AppColors.accentRed,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SavedAffirmationsScreen(),
                ),
              );
            },
          ),
          SwitchListTile(
            secondary: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.notifications_outlined,
                  color: AppColors.textPrimary),
            ),
            title: Text(
              'Notifikasi',
              style:
                  AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w500),
            ),
            value: vm.notificationEnabled,
            onChanged: vm.toggleNotification,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            activeColor: AppColors.primary,
          ),
          _buildSettingItem(
            icon: Icons.lock_outline,
            title: 'Privasi & Keamanan',
            onTap: () {
              Navigator.pushNamed(context, '/privacy_security');
            },
          ),
          _buildSettingItem(
            icon: Icons.help_outline,
            title: 'Bantuan & Dukungan (FAQ)',
            onTap: () {
              Navigator.pushNamed(context, '/faq');
            },
          ),
          _buildSettingItem(
            icon: Icons.people_outline,
            title: 'Tentang Kami',
            onTap: () {
              Navigator.pushNamed(context, '/about_us');
            },
          ),
          _buildSettingItem(
            icon: Icons.star_outline,
            title: 'Testimoni',
            onTap: () {
              Navigator.pushNamed(context, '/testimonials_screen');
            },
          ),
          _buildSettingItem(
            icon: Icons.info_outline,
            title: 'Tentang Aplikasi',
            onTap: () {
              Navigator.pushNamed(context, '/about_app');
            },
          ),

          const SizedBox(height: 24),

          // Sign Out Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Keluar'),
                      content: const Text(
                          'Apakah Anda yakin ingin keluar dari aplikasi?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Batal'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            vm.logout(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.error,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Keluar'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error.withValues(alpha: 0.1),
                  foregroundColor: AppColors.error,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Keluar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color ?? AppColors.textPrimary),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      minVerticalPadding: 16,
    );
  }
}

class _StatsCard extends StatelessWidget {
  final String value;
  final String label;
  final Gradient gradient;

  const _StatsCard({
    required this.value,
    required this.label,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
