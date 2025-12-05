import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class QuotePage extends StatelessWidget {
  final String quote;
  final VoidCallback onCopy;

  const QuotePage({
    super.key,
    required this.quote,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryLight,
            AppColors.primary,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background patterns
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1), width: 1),
              ),
            ),
          ),
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1), width: 1),
              ),
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.format_quote_rounded,
                  size: 64,
                  color: Colors.white70,
                ),
                const SizedBox(height: 24),

                Text(
                  quote,
                  style: AppTextStyles.h2.copyWith(
                    color: Colors.white,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left,
                ),

                const SizedBox(height: 24),

                const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.format_quote_rounded,
                    size: 64,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 40),

                // Copy Button
                Center(
                  child: OutlinedButton.icon(
                    onPressed: onCopy,
                    icon: const Icon(Icons.copy, color: Colors.white),
                    label: const Text('Salin Quote',
                        style: TextStyle(color: Colors.white)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Footer
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.mic, color: Colors.white, size: 24),
                const SizedBox(width: 8),
                Text(
                  "Memberdayakan Melalui Cerita!",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
