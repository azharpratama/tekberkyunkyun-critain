import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        // Title
                        const Text(
                          'Terhubung, Bagikan,\ndan Ceritakan\nPikiranmu',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            height: 1.2,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Description
                        Text(
                          'Terhubung dengan orang lain, bagikan cerita Anda, dan temukan dukungan sesuai dengan yang kamu rasakan. Crita.in menawarkan ruang aman dan rahasia di mana Anda bisa berbicara tanpa takut dihakimi.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/perpustakaan-cerita');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE87C55), // Orange color
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                          ),
                          child: const Text(
                            'Temukan Partner Bercerita',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Logos (Placeholder)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildLogoPlaceholder('logoipsum'),
                            _buildLogoPlaceholder('Logoipsum'),
                            _buildLogoPlaceholder('logoipsum'),
                            _buildLogoPlaceholder('Logoipsum'),
                          ],
                        ),
                        const SizedBox(height: 40),

                        // Illustration
                        Center(
                          child: Image.asset(
                            'assets/people-icon-pc.png',
                            height: 300,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),

                  // Green Section (Now part of scrollable content)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                    color: const Color(0xFF3A9D76), // Green color
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.mic_none_outlined,
                            color: Colors.white, size: 32),
                        const SizedBox(width: 12),
                        const Text(
                          'Memberdayakan Melalui Cerita!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.mic_none_outlined,
                            color: Colors.white, size: 32),
                      ],
                    ),
                  ),

                  // Landing Page Placeholder
                  Container(
                    height: 600,
                    width: double.infinity,
                    color: Colors.grey[100],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.web_asset, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'Landing Page Content',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Additional sections will go here',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoPlaceholder(String text) {
    return Row(
      children: [
        Icon(Icons.token, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
