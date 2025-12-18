import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Tentang Kami',
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
            const CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.people, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 24),
            Text(
              'Tim Critain',
              style: AppTextStyles.h1,
            ),
            const SizedBox(height: 16),
            const Text(
              'Kami berdedikasi untuk meningkatkan kesehatan mental masyarakat melalui teknologi. Misi kami adalah menyediakan platform yang aman dan mendukung bagi semua orang untuk berbagi cerita dan mendapatkan dukungan.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
