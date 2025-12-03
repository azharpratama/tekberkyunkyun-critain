import 'package:flutter/material.dart';

class PerpustakaanCerita extends StatelessWidget {
  final bool showAppBar;

  const PerpustakaanCerita({super.key, this.showAppBar = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: showAppBar
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                'Perpustakaan Cerita',
                style: TextStyle(color: Colors.black),
              ),
            )
          : null,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Icon(Icons.library_books_outlined,
                          color: Colors.grey[800]),
                      const SizedBox(width: 8),
                      Text(
                        '#PerpustakaanCerita',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Title
                  const Text(
                    'Baca dan Lihat\nBanyak Cerita\nSerupa',
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
                    'Lihat dan baca beberapa verita dari orang orang yang telah mengungkapkan secara anonim. Mungkin saja cerita mereka akan membantu kalian!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Illustration Placeholder
                  // Illustration
                  Center(
                    child: Image.asset(
                      'assets/people-icon-pc.png',
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Story Cards
                  const StoryCard(
                    title: 'Kisah Perjuangan\nAmanda Melawan Depresi',
                    description:
                        'Amanda adalah seorang wanita berusia 28 tahun yang bekerja sebagai desainer grafis di sebuah perusahaan teknologi. Dalam penampilan luar, ia terlihat baik-baik saja—produktif di tempat kerja, punya banyak teman, dan aktif di media sosial. Namun, di balik senyum dan prestasi, Amanda menyimpan beban mental yang tak terlihat oleh siapa pun.',
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    buttonColor: Color(0xFFE87C55), // Orange color from image
                  ),
                  const SizedBox(height: 16),
                  const StoryCard(
                    title: 'Dari Kecemasan Menuju\nKeberanian',
                    description:
                        'Rizki, seorang pria berusia 23 tahun, baru saja menyelesaikan kuliah dan mendapatkan pekerjaan pertama di sebuah perusahaan start-up. Awalnya, ia sangat bersemangat menghadapi tantangan baru. Namun, lambat laun, beban pekerjaan yang berat mulai membuatnya merasa cemas berlebihan. Setiap tugas yang diberikan terasa seperti beban besar yang tidak bisa ia selesaikan...',
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    buttonColor: Color(0xFFE87C55),
                  ),
                  const SizedBox(height: 16),
                  const StoryCard(
                    title:
                        'Mengatasi Burnout dan\nMenemukan Keseimbangan\nHidup',
                    description:
                        'Sheila adalah seorang ibu muda berusia 35 tahun yang juga bekerja penuh waktu sebagai manajer di sebuah perusahaan periklanan. Dengan dua anak kecil di rumah dan tuntutan pekerjaan yang sangat tinggi, Sheila sering merasa terjebak dalam kesibukan tanpa akhir. Setiap hari penuh dengan pertemuan, deadline yang mendesak, serta tanggung jawab rumah tangga yang menumpuk...',
                    backgroundColor:
                        Color(0xFF3A9D76), // Green color from image
                    textColor: Colors.white,
                    buttonColor: Color(0xFFE87C55),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StoryCard extends StatelessWidget {
  final String title;
  final String description;
  final Color backgroundColor;
  final Color textColor;
  final Color buttonColor;

  const StoryCard({
    super.key,
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.textColor,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            description,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 14,
              color: textColor.withValues(alpha: 0.9),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text(
              'Lihat Detail',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
