import 'package:flutter/material.dart';
import 'fitur_utama.dart' as reza;
import 'quotes_screen.dart';
import 'packages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const _HomeContent(),
      const reza.HomePage(),
      const QuotesScreen(),
      const PackagesScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green.shade600,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: 'Fitur',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_quote),
            label: 'Quotes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Packages',
          ),
        ],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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

                        // Button - Temukan Partner Bercerita
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

                  // Section Bawah - "Kami di sini untuk membantumu bercerita dan mendengar"
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Kami di sini untuk\nmembantumu bercerita dan\nmendengar',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Bullet points
                        _buildBulletPoint(
                          'Setiap individu memiliki kebutuhan berbeda. Kami hadir untuk mendukungmu dengan cara yang paling sesuai.',
                        ),
                        _buildBulletPoint(
                          'Orang yang selalu siap mendengarkan ceritamu dan memberikan saran yang bisa diandalkan.',
                        ),
                        _buildBulletPoint(
                          'Setiap percakapan dijaga kerahasiaannya. Kepercayaanmu adalah prioritas kami.',
                        ),
                        _buildBulletPoint(
                          'Kami membantu kamu menemukan kenyamanan dan kelegaan dalam setiap cerita.',
                        ),
                        const SizedBox(height: 32),
                        
                        // Illustration
                        Center(
                          child: Image.asset(
                            'assets/Group 2.png',
                            height: 250,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),

                  // Services Section
                  Container(
                    width: double.infinity,
                    color: const Color(0xFF1E1E1E), // Dark background
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Services',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Empowering Minds Our\nMental Health\nConsulting Services',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 40),
                        
                        // Mental Counseling Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2C2C2C), // Slightly lighter dark
                            borderRadius: BorderRadius.circular(0), // Sharp edges as per design
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Mental Counseling',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Lorem ipsum dolor sit amet\nconsectetur Convallis est',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 32),
                              ElevatedButton(
                                onPressed: () {
                                  // Action for detail
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE87C55), // Orange color
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 16),
                                ),
                                child: const Text(
                                  'See detail',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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


    Widget _buildBulletPoint(String text) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.play_arrow, size: 20, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
