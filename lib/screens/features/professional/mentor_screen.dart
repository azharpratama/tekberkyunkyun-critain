import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

const String _backgroundImage = 'assets/background_mentor.png';
const String _iconGrowth = 'assets/icon_professional_growth.png';
const String _iconBurnout = 'assets/icon_reduced_burnout.png';
const String _iconFooter = 'assets/icon_footer_star.png';

class MentorScreen extends StatelessWidget {
  const MentorScreen({super.key});

  static const Color textColor = Colors.white;

  Widget _buildFeatureItem({
    required String iconPath,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          iconPath,
          width: 40,
          height: 40,
          color: textColor,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.star, color: textColor, size: 40),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.h2.copyWith(
                  color: textColor,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: textColor.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: const AssetImage(_backgroundImage),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.primaryDark,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'Mentor',
                    style: AppTextStyles.h1.copyWith(
                      fontSize: 48,
                      color: textColor,
                    ),
                  ),
                  Text(
                    'Introducing Experienced\nConsulting',
                    style: AppTextStyles.h3.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildFeatureItem(
                    iconPath: _iconGrowth,
                    title: 'Professional\nGrowth',
                    description:
                        'Lorem ipsum dolor sit amet consectetur. Convallis est urna adipiscing fringilla nulla',
                  ),
                  const SizedBox(height: 30),
                  _buildFeatureItem(
                    iconPath: _iconBurnout,
                    title: 'Reduced\nBurnout',
                    description:
                        'Lorem ipsum dolor sit amet consectetur. Convallis est urna adipiscing fringilla nulla',
                  ),
                  const Spacer(),

                  // Contact Button (New Feature)
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Fitur kontak mentor akan segera hadir!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primaryDark,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 48, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Hubungi Mentor',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: const AssetImage(_iconFooter),
                        width: 24,
                        height: 24,
                        color: textColor,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.star, color: textColor, size: 24),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Memberdayakan Melalui Cerita!',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
