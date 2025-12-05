import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AnimatedHeartButton extends StatefulWidget {
  final bool isSaved;
  final VoidCallback onTap;
  final bool transparent;

  const AnimatedHeartButton({
    super.key,
    required this.isSaved,
    required this.onTap,
    this.transparent = false,
  });

  @override
  State<AnimatedHeartButton> createState() => _AnimatedHeartButtonState();
}

class _AnimatedHeartButtonState extends State<AnimatedHeartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward().then((_) => _controller.reverse());
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding:
              widget.transparent ? EdgeInsets.zero : const EdgeInsets.all(12),
          decoration: widget.transparent
              ? null
              : BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
          child: Icon(
            widget.isSaved ? Icons.favorite : Icons.favorite_border,
            color: widget.isSaved
                ? Colors.red
                : (widget.transparent ? AppColors.accentRed : Colors.grey),
            size: 28,
          ),
        ),
      ),
    );
  }
}
