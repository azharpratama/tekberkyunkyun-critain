import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final double bounce = (1.0 +
                      (0.5 *
                          (0.5 -
                              (0.5 - (_controller.value - index * 0.2).abs())
                                  .abs())))
                  .clamp(1.0, 1.5);

              // Simpler opacity animation
              final double opacity = (0.4 +
                  0.6 *
                      (1.0 -
                              ((_controller.value - index * 0.33) % 1.0).abs() *
                                  2)
                          .clamp(0.0, 1.0));

              return Transform.translate(
                offset: Offset(0, -4 * (bounce - 1.0) * 5),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.textSecondary.withValues(alpha: opacity),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
