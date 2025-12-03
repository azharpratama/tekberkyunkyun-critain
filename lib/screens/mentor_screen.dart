import 'package:flutter/material.dart';

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
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
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
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mentor',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const Text(
                    'Introducing Experienced\nConsulting',
                    style: TextStyle(
                      fontSize: 18,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: const AssetImage(_iconFooter),
                        width: 24,
                        height: 24,
                        color: textColor,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Memberdayakan Melalui Cerita!',
                        style: TextStyle(
                          fontSize: 16,
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
