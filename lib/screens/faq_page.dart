import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {
        "q": "What is environmental-friendly product?",
        "a":
            "Eco-friendly products are products that contribute to green living or practices that help conserve resources like water and energy."
      },
      {
        "q": "What is the benefit of recycling?",
        "a":
            "Recycling reduces pollution, saves energy, and decreases landfill waste."
      },
      {
        "q": "How can I benefit from recycling?",
        "a":
            "You help the planet, reduce waste, and support sustainability programs."
      },
      {
        "q": "What types of items can be recycled?",
        "a": "Paper, plastic, metal, glass, and certain electronics."
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Background motif seperti desain
          Positioned.fill(child: CustomPaint(painter: FAQBackgroundPainter())),

          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "FAQ",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Frequently Asked Questions\nEverything about Critain",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 30),

                // Kotak FAQ seperti desain
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: Column(
                    children: faqs.map((f) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              f["q"]!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 6),
                            Text(f["a"]!, style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Background motif garis-garis seperti desain
class FAQBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (double i = 0; i < size.height; i += 40) {
      Path path = Path();
      path.moveTo(0, size.height - i);
      path.quadraticBezierTo(
          size.width * 0.5, size.height - i - 60, size.width, size.height - i);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
