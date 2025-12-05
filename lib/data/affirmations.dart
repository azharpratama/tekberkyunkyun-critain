import 'package:flutter/material.dart';

class Affirmation {
  final String text;
  final Color color;

  const Affirmation({required this.text, required this.color});
}

final List<Affirmation> defaultAffirmations = [
  const Affirmation(
    text:
        'Kamu adalah individu yang berharga. Kehadiranmu berarti bagi dunia ini. 🌟',
    color: Color(0xFFFFCDD2),
  ),
  const Affirmation(
    text:
        'Hari ini mungkin berat, tapi kamu lebih kuat dari yang kamu kira. 💪',
    color: Color(0xFFB3E5FC),
  ),
  const Affirmation(
    text:
        'Tidak apa-apa untuk merasa tidak baik-baik saja. Kamu layak untuk beristirahat. 🫂',
    color: Color(0xFFC8E6C9),
  ),
  const Affirmation(
    text: 'Setiap langkah kecil tetap merupakan kemajuan. Tetap semangat! ✨',
    color: Color(0xFFFFE0B2),
  ),
  const Affirmation(
    text: 'Kamu tidak sendirian dalam perjalanan ini. Ada yang peduli. ❤️',
    color: Color(0xFFE1BEE7),
  ),
];
