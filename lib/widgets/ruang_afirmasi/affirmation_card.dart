import 'package:flutter/material.dart';

class AffirmationCard extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const AffirmationCard({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Container(
            constraints: const BoxConstraints(
                maxWidth:
                    300), // Constrain width to force wrapping before scaling
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28, // Increased base size
                height: 1.3,
                fontWeight: FontWeight.w600,
                color: textColor,
                fontFamily: 'Playfair Display',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
