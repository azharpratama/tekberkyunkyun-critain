import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Tentang Aplikasi',
            style: TextStyle(color: AppColors.textPrimary)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.favorite, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 24),
            Text(
              'Ceritain',
              style: AppTextStyles.h1,
            ),
            Text(
              'Versi 1.0.0',
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),
            const Text(
              'Ceritain adalah aplikasi kesehatan mental yang dirancang untuk membantu Anda mengelola stres, kecemasan, dan meningkatkan kesejahteraan emosional Anda. Dengan fitur-fitur seperti jurnal harian, meditasi, dan konseling profesional, kami berharap dapat menjadi teman setia Anda dalam perjalanan menuju kesehatan mental yang lebih baik.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
