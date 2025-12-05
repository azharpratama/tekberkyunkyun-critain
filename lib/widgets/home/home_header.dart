import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/profile_viewmodel.dart';

import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_dimens.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.homeGreeting,
              style: AppTextStyles.h2.copyWith(color: Colors.black),
            ),
            const SizedBox(height: AppDimens.p4),
            Text(
              AppStrings.homeSubtitle,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.black.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/profile');
          },
          borderRadius: BorderRadius.circular(AppDimens.r30),
          child: Consumer<ProfileViewModel>(
            builder: (context, vm, child) {
              return CircleAvatar(
                radius: AppDimens.r30,
                backgroundColor: Colors.grey[200],
                backgroundImage: vm.avatarUrl.isNotEmpty
                    ? NetworkImage(vm.avatarUrl)
                    : const AssetImage(AppAssets.profilePlaceholder)
                        as ImageProvider,
              );
            },
          ),
        ),
      ],
    );
  }
}
