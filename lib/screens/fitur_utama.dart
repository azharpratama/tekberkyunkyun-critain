import 'package:flutter/material.dart';
import 'ruang_afirmasi.dart';
import 'ruang_bercerita.dart';
import 'perpustakaan_cerita.dart';

void main() {
  runApp(const CritainApp());
}

class CritainApp extends StatelessWidget {
  const CritainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Critain',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

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
      routeBuilder: (context) => const PerpustakaanCeritaPage(),
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
    final double topPadding = MediaQuery.of(context).padding.top + 24;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 18).copyWith(top: topPadding),
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
                          highlight: f.highlight,
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

              // Footer button
              ElevatedButton(
                onPressed: () {
                  // contoh aksi tombol footer
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Memberdayakan Melalui Cerita!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade500,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Memberdayakan Melalui Cerita!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Kami di sini untuk\nmembantumu bercerita  dan mendengar",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                const _Bullet(text:
                    "Setiap individu memiliki kebutuhan berbeda. Kami hadir untuk mendukungmu dengan cara yang paling sesuai."),
                const _Bullet(text:
                    "Orang yang selalu siap mendengarkan ceritamu dan memberikan saran yang bisa ditindaklanjuti."),
                const _Bullet(text:
                    "Setiap percakapan dijaga kerahasiaannya. Kepercayaanmu adalah prioritas kami."),
                const _Bullet(text:
                    "Kami membantu kamu menemukan kenyamanan dan kelegaan dalam setiap cerita."),

                const SizedBox(height: 24),

                // ------------------ Ilustrasi ------------------
                Image.asset(
                  'assets/ruangbercerita_illus.png',
                  height: 220,
                ),

                const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}


class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.play_arrow_rounded, size: 22),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.3,
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