import 'package:flutter/material.dart';
import '../models/faq_item.dart';

class FAQViewModel extends ChangeNotifier {
  final List<FAQItem> _faqs = const [
    FAQItem(
      question: "Apa itu aplikasi Ceritain?",
      answer:
          "Ceritain adalah aplikasi kesehatan mental yang menyediakan ruang aman bagi Anda untuk berbagi cerita, melakukan journaling, mendapatkan afirmasi positif, dan terhubung dengan profesional kesehatan mental.",
    ),
    FAQItem(
      question: "Apakah privasi saya terjaga?",
      answer:
          "Ya, privasi Anda adalah prioritas utama kami. Semua data percakapan dan profil Anda dienkripsi dan dijaga kerahasiaannya sesuai dengan standar keamanan data.",
    ),
    FAQItem(
      question: "Bagaimana cara melakukan konseling?",
      answer:
          "Anda dapat memilih menu 'Konsultasi Profesional', pilih psikolog atau konselor yang sesuai dengan kebutuhan Anda, dan jadwalkan sesi konsultasi melalui aplikasi.",
    ),
    FAQItem(
      question: "Apakah layanan ini berbayar?",
      answer:
          "Aplikasi ini dapat diunduh gratis dengan fitur dasar. Namun, untuk sesi konseling profesional dan beberapa fitur premium lainnya, mungkin dikenakan biaya berlangganan atau per sesi.",
    ),
    FAQItem(
      question: "Apa itu Ruang Bercerita?",
      answer:
          "Ruang Bercerita adalah fitur di mana Anda bisa menuliskan perasaan atau pengalaman Anda secara anonim atau pribadi untuk membantu melegakan pikiran.",
    ),
    FAQItem(
      question: "Bagaimana jika saya dalam kondisi darurat?",
      answer:
          "Jika Anda atau seseorang yang Anda kenal dalam bahaya segera, silakan hubungi layanan darurat setempat atau hotline pencegahan bunuh diri segera. Aplikasi ini bukan pengganti layanan darurat.",
    ),
  ];

  List<FAQItem> get faqs => _faqs;
}
