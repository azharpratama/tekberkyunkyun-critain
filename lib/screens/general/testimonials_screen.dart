import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../viewmodels/testimonials_viewmodel.dart';
import '../../widgets/general/testimonial_card.dart';

const String _backgroundAsset = 'assets/maps_background.png';

class TestimonialsScreen extends StatelessWidget {
  const TestimonialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TestimonialsViewModel(),
      child: const _TestimonialsContent(),
    );
  }
}

class _TestimonialsContent extends StatelessWidget {
  const _TestimonialsContent();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TestimonialsViewModel>();
    const double scaleFactor = 0.8;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: const AssetImage(_backgroundAsset),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.background,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Back Button
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AppColors.primary),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Testimonials',
                  style: AppTextStyles.h1.copyWith(
                    fontSize: 32,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'Healing Words Testimonials from\na Mental Health Consultant',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h3.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 380,
                  child: PageView.builder(
                    controller: vm.pageController,
                    itemCount: vm.testimonials.length,
                    itemBuilder: (context, index) {
                      double scale = 1.0;
                      double diff = index - vm.currPageValue;
                      scale = 1 - (diff.abs() * (1 - scaleFactor));
                      if (diff.abs() >= 1.0) {
                        scale = scaleFactor;
                      }

                      return TestimonialCard(
                        testimonial: vm.testimonials[index],
                        scale: scale,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 300,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                    opacity: vm.currentPage > 0 ? 1.0 : 0.4,
                    child: _buildNavButton(
                      icon: Icons.arrow_back_ios_new,
                      onPressed: vm.currentPage > 0 ? vm.previousPage : null,
                    ),
                  ),
                  Opacity(
                    opacity:
                        vm.currentPage < vm.testimonials.length - 1 ? 1.0 : 0.4,
                    child: _buildNavButton(
                      icon: Icons.arrow_forward_ios,
                      onPressed: vm.currentPage < vm.testimonials.length - 1
                          ? vm.nextPage
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton({required IconData icon, VoidCallback? onPressed}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: onPressed != null
            ? AppColors.secondary
            : AppColors.secondary.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
