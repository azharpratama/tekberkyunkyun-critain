class BlogPost {
  final String id;
  final String title;
  final String excerpt;
  final String content;
  final String author;
  final String date;
  final String imageUrl;
  final String category;
  final String readTime;

  const BlogPost({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.author,
    required this.date,
    required this.imageUrl,
    required this.category,
    required this.readTime,
  });
}

final List<BlogPost> blogPosts = [
  const BlogPost(
    id: '1',
    title: 'Mengenal Anxiety: Lebih dari Sekadar Rasa Cemas',
    excerpt:
        'Kecemasan adalah hal yang wajar, namun ketika ia mulai mengganggu aktivitas sehari-hari, mungkin itu adalah tanda gangguan kecemasan.',
    content: '''
Kecemasan adalah respons alami tubuh terhadap stres. Ini adalah perasaan takut atau khawatir tentang apa yang akan datang. Hari pertama sekolah, pergi ke wawancara kerja, atau memberikan pidato dapat menyebabkan kebanyakan orang merasa takut dan gugup.

Namun, jika perasaan cemas Anda ekstrem, bertahan lebih dari enam bulan, dan mengganggu hidup Anda, Anda mungkin memiliki gangguan kecemasan.

### Apa itu Gangguan Kecemasan?
Gangguan kecemasan adalah jenis kondisi kesehatan mental. Jika Anda memilikinya, Anda mungkin merespons hal-hal tertentu dengan ketakutan dan ketakutan fisik. Tanda-tanda fisik kecemasan meliputi detak jantung yang cepat dan berkeringat.

### Gejala Umum
- Merasa gugup, gelisah, atau tegang
- Memiliki rasa bahaya yang akan datang, panik, atau malapetaka
- Memiliki detak jantung yang meningkat
- Bernapas dengan cepat (hiperventilasi)
- Berkeringat
- Gemetar
- Merasa lemah atau lelah

### Cara Mengelola Kecemasan
1. **Tidur yang cukup.** Kurang tidur dapat memicu kecemasan.
2. **Batasi kafein dan alkohol.** Keduanya dapat memperburuk kecemasan.
3. **Makan makanan yang seimbang.**
4. **Latihan pernapasan dalam.** Menarik napas dalam-dalam dapat membantu menenangkan tubuh Anda.

Ingat, Anda tidak sendirian. Jika kecemasan Anda terasa berat, jangan ragu untuk mencari bantuan profesional.
    ''',
    author: 'Dr. Sarah Johnson',
    date: '29 Nov 2025',
    imageUrl:
        'assets/blog_anxiety.png', // Placeholder, will need to handle assets
    category: 'Kesehatan Mental',
    readTime: '5 min read',
  ),
  const BlogPost(
    id: '2',
    title: 'Pentingnya Self-Care di Tengah Kesibukan',
    excerpt:
        'Merawat diri sendiri bukanlah tindakan egois. Ini adalah langkah penting untuk menjaga kesehatan mental dan fisik Anda agar tetap prima.',
    content: '''
Di dunia yang serba cepat ini, kita sering lupa untuk meluangkan waktu bagi diri sendiri. Kita terjebak dalam rutinitas pekerjaan, tugas rumah tangga, dan kewajiban sosial.

### Mengapa Self-Care Penting?
Self-care membantu Anda mengisi ulang energi fisik dan mental Anda. Ini membantu Anda mengelola stres, menurunkan risiko penyakit, dan meningkatkan energi Anda.

### Ide Self-Care Sederhana
- **Membaca buku** favorit Anda selama 30 menit.
- **Berjalan-jalan** di alam terbuka.
- **Mandi air hangat** dengan aromaterapi.
- **Menulis jurnal** tentang perasaan Anda.
- **Mematikan ponsel** selama satu jam sebelum tidur.

Mulailah dengan langkah kecil. Luangkan waktu 10-15 menit setiap hari hanya untuk diri Anda sendiri.
    ''',
    author: 'Rina Melati',
    date: '28 Nov 2025',
    imageUrl: 'assets/people-icon-pc.png', // Temporary placeholder
    category: 'Lifestyle',
    readTime: '3 min read',
  ),
  const BlogPost(
    id: '3',
    title: 'Mengatasi Burnout: Tanda dan Solusi',
    excerpt:
        'Burnout bukan hanya sekadar kelelahan biasa. Kenali tanda-tandanya sebelum terlambat dan pelajari cara memulihkannya.',
    content: '''
Burnout adalah keadaan kelelahan emosional, fisik, dan mental yang disebabkan oleh stres yang berlebihan dan berkepanjangan. Ini terjadi ketika Anda merasa kewalahan, terkuras secara emosional, dan tidak mampu memenuhi tuntutan yang terus-menerus.

### Tanda-tanda Burnout
- Kelelahan kronis.
- Insomnia.
- Pelupa dan sulit berkonsentrasi.
- Gejala fisik seperti sakit dada, jantung berdebar, sesak napas.
- Sering sakit.
- Kehilangan nafsu makan.
- Kecemasan dan depresi.
- Kemarahan.

### Cara Mengatasi
1. **Evaluasi Prioritas.** Lihat kembali apa yang penting bagi Anda.
2. **Bicara dengan Atasan.** Jika pekerjaan adalah penyebabnya, diskusikan beban kerja Anda.
3. **Kurangi Eksposur terhadap Stres.** Belajarlah untuk berkata tidak.
4. **Olahraga Teratur.** Aktivitas fisik adalah pereda stres yang ampuh.

Jangan abaikan tanda-tanda burnout. Kesehatan Anda adalah aset yang paling berharga.
    ''',
    author: 'Budi Santoso',
    date: '25 Nov 2025',
    imageUrl: 'assets/Group 2.png', // Temporary placeholder
    category: 'Karir',
    readTime: '7 min read',
  ),
];
