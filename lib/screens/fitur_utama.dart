import 'package:flutter/material.dart';
import 'ruang_afirmasi.dart';
import 'ruang_bercerita.dart';
import 'perpustakaan-cerita.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(viewportFraction: 0.82);
  int _currentPage = 0;

  final List<_Feature> features = [
    _Feature(
      title: 'Ruang Afirmasi',
      description:
          'Kirimkan dukungan atau pesan apresiasi kepada sesama pengguna secara anonim.',
      icon: Icons.favorite_outline,
      routeBuilder: (context) => const RuangAfirmasiPage(),
    ),
    _Feature(
      title: 'Ruang Bercerita',
      description:
          'Berbagi cerita secara pribadi dan rahasia dengan pengguna lain yang bersedia mendengarkan.',
      icon: Icons.person_outline,
      routeBuilder: (context) => const RuangBerceritaPage(),
      highlight: true,
    ),
    _Feature(
      title: 'Perpustakaan Cerita',
      description:
          'Bagikan pengalaman Anda yang dapat diakses oleh pengguna lain sebagai inspirasi dan pelajaran.',
      icon: Icons.menu_book_outlined,
      routeBuilder: (context) => const PerpustakaanCerita(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final int page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() => _currentPage = page);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _openFeature(int index) {
    final builder = features[index].routeBuilder;
    Navigator.push(context, MaterialPageRoute(builder: builder));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Fitur Utama',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18).copyWith(top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                const SizedBox(height: 6),
                const Text(
                  "Temukan Fitur yang\nMembantumu\nMenjadi Lebih Baik",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Critain dilengkapi dengan berbagai fitur yang dirancang untuk\nmembantumu mengelola kesehatan mental dengan lebih baik.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),

                const SizedBox(height: 28),

                // Slide area
                SizedBox(
                  height: 220,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: features.length,
                    itemBuilder: (context, index) {
                      final f = features[index];
                      final bool active = index == _currentPage;
                      return AnimatedPadding(
                        duration: const Duration(milliseconds: 300),
                        padding: EdgeInsets.only(
                          right: 12,
                          left: 12,
                          top: active ? 0 : 12,
                          bottom: active ? 0 : 12,
                        ),
                        child: GestureDetector(
                          onTap: () => _openFeature(index),
                          child: FeatureCard(
                            title: f.title,
                            description: f.description,
                            icon: f.icon,
                            highlight: active,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 14),

                // Dots indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    features.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: _currentPage == i ? 22 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _currentPage == i ? Colors.green.shade600 : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

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
                        'Orang yang selalu siap mendengarkan ceritamu dan memberikan saran yang bisa ditindaklanjuti.',
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
                    ],
                  ),
                ),
              ),
            ),
            
            // Footer button - Full Screen
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              color: const Color(0xFF3A9D76), // Green color
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.mic_none_outlined,
                      color: Colors.white, size: 32),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Center(
                        child: Text(
                          'Memberdayakan Melalui Cerita!',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Icon(Icons.mic_none_outlined,
                      color: Colors.white, size: 32),
                ],
              ),
            ),
          ],
        ),
      ),
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


class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool highlight;

  const FeatureCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = highlight ? Colors.green.shade200 : Colors.white;
    final border = highlight ? Border.all(color: Colors.green.shade400, width: 0) : null;

    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: border,
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 34, color: Colors.black87),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

// small helper class
class _Feature {
  final String title;
  final String description;
  final IconData icon;
  final WidgetBuilder routeBuilder;
  final bool highlight;
  const _Feature({
    required this.title,
    required this.description,
    required this.icon,
    required this.routeBuilder,
    this.highlight = false,
  });
}