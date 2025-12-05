import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/testimonial.dart';

class TestimonialCard extends StatelessWidget {
  final Testimonial testimonial;
  final double scale;

  const TestimonialCard({
    super.key,
    required this.testimonial,
    this.scale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.diagonal3Values(1.0, scale, 1.0),
      alignment: Alignment.center,
      child: Container(
        height: 300 * scale,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [AppColors.primaryLight, AppColors.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(testimonial.imagePath),
              backgroundColor: Colors.white,
              onBackgroundImageError: (exception, stackTrace) {
                // Handle image error gracefully
              },
              child: const Icon(Icons.person, size: 40, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              testimonial.quote,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Text(
              testimonial.name,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
