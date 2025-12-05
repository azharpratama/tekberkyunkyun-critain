import 'package:flutter/material.dart';

class PulsingAvatar extends StatefulWidget {
  final IconData icon;
  final Color color;

  const PulsingAvatar({super.key, required this.icon, required this.color});

  @override
  State<PulsingAvatar> createState() => _PulsingAvatarState();
}

class _PulsingAvatarState extends State<PulsingAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Pulsing circles
          ...List.generate(3, (index) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final progress = (_controller.value + (index * 0.33)) % 1.0;
                return Opacity(
                  opacity: (1.0 - progress) * 0.5,
                  child: Container(
                    width: 50 + (progress * 100),
                    height: 50 + (progress * 100),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.color.withValues(alpha: 0.3),
                    ),
                  ),
                );
              },
            );
          }),
          // Center icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(widget.icon, size: 40, color: widget.color),
          ),
        ],
      ),
    );
  }
}
