import 'package:flutter/material.dart';

// --- Anda mungkin perlu menyesuaikan warna dan font di sini ---
const Color _primaryColor = Color(0xFF4CAF50); // Contoh warna hijau dari desain
const Color _accentColor = Colors.deepOrange; // Contoh warna oranye untuk tombol

class NewsletterPage extends StatelessWidget {
  const NewsletterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold memberikan struktur dasar untuk halaman
    return Scaffold(
      // Kita asumsikan tidak ada AppBar di desain ini
      // Background kustom (garis-garis) akan diabaikan
      // karena biasanya melibatkan CustomPainter yang kompleks.

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Jarak atas (untuk mengimbangi area status bar)
              const SizedBox(height: 80),

              // Bagian Judul Utama
              Text(
                'Join To Our Newsletter',
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

              // Input Field dan Tombol Subscribe
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Input Field Email
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Your email',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Tombol Subscribe Us
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Tambahkan logika pengiriman email ke backend
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Berlangganan!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accentColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Subscribe Us',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              // Area yang menampilkan kartu/konten buletin (Kotak hitam-putih di desain)
              // Karena ini adalah area placeholder, saya akan membuatnya sebagai container berukuran besar.
              const SizedBox(height: 40),
              Container(
                height: 400, // Ketinggian yang diasumsikan
                width: double.infinity,
                // Kita bisa mengganti ini dengan ListView.builder untuk menampilkan daftar buletin sebelumnya
                decoration: BoxDecoration(
                  color: Colors.grey.shade200, // Warna abu-abu terang sebagai placeholder
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Area Daftar Buletin Sebelumnya',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}