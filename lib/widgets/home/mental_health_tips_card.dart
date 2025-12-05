import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_dimens.dart';

class MentalHealthTipsCard extends StatelessWidget {
  const MentalHealthTipsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.p20),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimens.r16),
        border: Border.all(
          color: AppColors.info.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb,
                  color: AppColors.info, size: AppDimens.p20),
              const SizedBox(width: AppDimens.p8),
              Text(
                AppStrings.mentalHealthTipsTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.info.withValues(alpha: 0.8), // Darker shade
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.p12),
          Text(
            AppStrings.mentalHealthTipContent,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.info.withValues(alpha: 0.8),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
