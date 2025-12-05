import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

const String _backgroundAsset = 'assets/maps_background.png';
const String _mapImageAsset = 'assets/map_placeholder.png';

class MapsScreen extends StatelessWidget {
  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Back Button
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AppColors.primary),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    'Maps',
                    style: AppTextStyles.h1.copyWith(
                      fontSize: 32,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    'Mapping Out Mental Health\nConsulting Strategies',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 15,
                              offset: Offset(0, 5)),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                _mapImageAsset,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: Icon(Icons.map,
                                        size: 50, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            const Center(
                              child: Icon(
                                Icons.location_on,
                                color: AppColors.warning,
                                size: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
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
}
