import 'package:flutter/material.dart';

// --- Anda mungkin perlu menyesuaikan warna dan font di sini ---
const Color _primaryColor = Color(0xFF4CAF50); // Contoh warna hijau dari desain

// Model data sederhana untuk item Komunitas
class CommunityItem {
  final String title;
  final String description;
  final String imageUrl; // Placeholder untuk gambar

  CommunityItem({required this.title, required this.description, required this.imageUrl});
}

// Data dummy untuk ditampilkan
final List<CommunityItem> _communityItems = [
  CommunityItem(
    title: 'Relaxation',
    description: 'Lorem ipsum dolor sit amet consectetur. Convallis est urna.',
    imageUrl: 'assets/image1.jpg', // Ganti dengan path aset Anda
  ),
  CommunityItem(
    title: 'Meditation',
    description: 'Amet consectetur adipiscing elit. Nulla vitae elit.',
    imageUrl: 'assets/image2.jpg',
  ),
  CommunityItem(
    title: 'Wellness',
    description: 'Sit amet, consectetur adipiscing elit. Sed do eiusmod tempor.',
    imageUrl: 'assets/image3.jpg',
  ),
];

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Jarak atas
              const SizedBox(height: 80),

              // Bagian Judul Utama
              Text(
                'Comunity',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: _primaryColor,
                ),
              ),
              const SizedBox(height: 8),

              // Bagian Deskripsi
              const Text(
                'Lorem ipsum dolor sit amet consectetur.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),

              // Daftar Kartu Komunitas
              ListView.builder(
                shrinkWrap: true, // Penting agar ListView bisa berada di dalam SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(), // Menonaktifkan scrolling ganda
                itemCount: _communityItems.length,
                itemBuilder: (context, index) {
                  final item = _communityItems[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: _buildCommunityCard(context, item),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk membuat tampilan kartu komunitas
  Widget _buildCommunityCard(BuildContext context, CommunityItem item) {
    return InkWell(
      onTap: () {
        // TODO: Tambahkan logika navigasi ke detail komunitas
        print('Navigasi ke ${item.title}');
      },
      child: Container(
        height: 180, // Tinggi kartu yang ditetapkan
        decoration: BoxDecoration(
          color: Colors.black, // Warna latar belakang jika gambar tidak dimuat
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Gambar Latar Belakang (Anda harus memiliki aset gambar ini)
            // Karena desain menggunakan placeholder catur, saya menggunakan Container untuk simulasi.
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              // Ganti Container ini dengan Image.asset(item.imageUrl) jika Anda punya aset
              child: Container(
                color: Colors.grey.shade400, // Placeholder
                child: Center(
                  child: Text(
                    'Gambar Placeholder',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                ),
              ),
            ),

            // Overlay Gelap (untuk membuat teks lebih menonjol)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),

            // Teks Overlay
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}