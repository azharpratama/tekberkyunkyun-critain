import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_dimens.dart';
import '../../screens/features/professional/consultation_screen.dart';

class QuickActionsGrid extends StatelessWidget {
  final Function(int) onTabChange;

  const QuickActionsGrid({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.quickActionsTitle,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppDimens.p16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppDimens.p16,
          crossAxisSpacing: AppDimens.p16,
          childAspectRatio: 1.1,
          children: [
            _QuickActionCard(
              icon: Icons.forum,
              title: AppStrings.actionBerceritaTitle,
              description: AppStrings.actionBerceritaDesc,
              gradient: const LinearGradient(
                colors: [AppColors.secondary, AppColors.secondaryDark],
              ),
              onTap: () => onTabChange(1), // Switch to Bercerita tab
            ),
            _QuickActionCard(
              icon: Icons.favorite,
              title: AppStrings.actionAfirmasiTitle,
              description: AppStrings.actionAfirmasiDesc,
              gradient: const LinearGradient(
                colors: [AppColors.accentRed, Color(0xFFD15D5D)],
              ),
              onTap: () => onTabChange(2), // Switch to Afirmasi tab
            ),
            _QuickActionCard(
              icon: Icons.psychology,
              title: AppStrings.actionConsultationTitle,
              description: AppStrings.actionConsultationDesc,
              gradient: const LinearGradient(
                colors: [AppColors.accentPurple, Color(0xFF7B1FA2)],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConsultationScreen(),
                  ),
                );
              },
            ),
            _QuickActionCard(
              icon: Icons.library_books,
              title: AppStrings.actionWawasanTitle,
              description: AppStrings.actionWawasanDesc,
              gradient: const LinearGradient(
                colors: [AppColors.accentOrange, Color(0xFFF57C00)],
              ),
              onTap: () => onTabChange(3), // Switch to Wawasan tab
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Gradient gradient;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.r16),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(AppDimens.r16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.p16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(AppDimens.r12),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(height: AppDimens.p12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppDimens.p4),
              Text(
                description,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
