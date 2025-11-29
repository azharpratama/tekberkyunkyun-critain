import 'package:flutter/material.dart';

class QuotesScreen extends StatelessWidget {
  const QuotesScreen({super.key});

  final List<String> quotes = const [
    "Self-care is not a luxury. It's a necessity. Without it, we cannot be our best selves, mentally, emotionally, or physically.",
    "The only way to do great work is to love what you do.",
    "Believe you can and you're halfway there.",
    "Your time is limited, so don't waste it living someone else's life.",
    "The future belongs to those who believe in the beauty of their dreams."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          return QuotePage(quote: quotes[index]);
        },
      ),
    );
  }
}

class QuotePage extends StatelessWidget {
  final String quote;

  const QuotePage({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF81C784), // Light Green
            Color(0xFF2E7D32), // Dark Green
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background patterns (optional, simplified as circles/lines if needed, 
          // but for now just gradient is fine or we can add some CustomPaint later)
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
              ),
            ),
          ),
           Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Opening Quote Icon
                const Icon(
                  Icons.format_quote_rounded,
                  size: 64,
                  color: Colors.white70,
                ),
                const SizedBox(height: 24),
                
                // Quote Text
                Text(
                  quote,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto', // Default flutter font, but good to specify if we had custom
                  ),
                  textAlign: TextAlign.left,
                ),
                
                const SizedBox(height: 24),
                
                // Closing Quote Icon
                const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.format_quote_rounded,
                    size: 64,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          
          // Footer
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.mic, color: Colors.white, size: 24),
                const SizedBox(width: 8),
                Text(
                  "Memberdayakan Melalui Cerita!",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
