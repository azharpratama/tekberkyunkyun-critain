import 'package:flutter/material.dart';

import 'mentor_screen.dart';
import 'team_screen.dart';
import 'maps_screen.dart';
import 'testimonials_screen.dart';

// Konstanta Aset dan Warna
const String _backgroundAsset = 'assets/maps_background.png';
const Color _greenColor = Color(0xFF5AB664);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  Widget _buildNavButton(
      BuildContext context, String title, Widget targetScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetScreen),
          );
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          backgroundColor: _greenColor, // Menggunakan warna hijau tema
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Atur Scaffold menjadi transparan untuk menampilkan Stack Background
      backgroundColor: Colors.transparent,
      // Hapus AppBar agar tampilan lebih bersih dan fullscreen,
      // atau gunakan AppBar transparan jika diperlukan judul
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent, // AppBar transparan
        elevation: 0, // Hapus bayangan
      ),
      body: Stack(
        children: [
          // 1. Latar Belakang (maps_background.png)
          Positioned.fill(
            child: Image(
              image: const AssetImage(_backgroundAsset),
              fit: BoxFit.cover,
            ),
          ),

          // 2. Konten Utama (Tombol Navigasi)
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(
                      'Welcome to Critain',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: _greenColor,
                      ),
                    ),
                    const Text(
                      'Pilih halaman untuk melanjutkan:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Tombol Navigasi
                    _buildNavButton(
                        context, 'Mentor Screen', const MentorScreen()),
                    _buildNavButton(context, 'Team Screen', const TeamScreen()),
                    _buildNavButton(context, 'Maps Screen', const MapsScreen()),
                    _buildNavButton(context, 'Testimonials Screen',
                        const TestimonialsScreen()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
