import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Privasi & Keamanan',
            style: TextStyle(color: AppColors.textPrimary)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kebijakan Privasi',
              style: AppTextStyles.h2,
            ),
            const SizedBox(height: 16),
            const Text(
              'Kami menghargai privasi Anda dan berkomitmen untuk melindungi data pribadi Anda. Informasi yang kami kumpulkan hanya digunakan untuk meningkatkan pengalaman Anda dalam menggunakan aplikasi ini.',
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: 24),
            Text(
              'Keamanan Data',
              style: AppTextStyles.h2,
            ),
            const SizedBox(height: 16),
            const Text(
              'Kami menggunakan standar keamanan industri untuk melindungi informasi Anda dari akses yang tidak sah. Data Anda dienkripsi dan disimpan dengan aman.',
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
