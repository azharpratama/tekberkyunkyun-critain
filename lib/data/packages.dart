import 'package:flutter/material.dart';

class Package {
  final String title;
  final String price;
  final String? period;
  final List<String> features;
  final Color color;
  final Color textColor;
  final Color buttonColor;
  final Color? buttonTextColor;
  final String buttonText;
  final bool isCurrent;
  final bool isRecommended;

  const Package({
    required this.title,
    required this.price,
    this.period,
    required this.features,
    required this.color,
    required this.textColor,
    required this.buttonColor,
    this.buttonTextColor,
    required this.buttonText,
    this.isCurrent = false,
    this.isRecommended = false,
  });
}

final List<Package> subscriptionPackages = [
  const Package(
    title: 'Free',
    price: 'Rp 0',
    features: [
      'Ruang Bercerita (peer support)',
      'Ruang Afirmasi',
      'Artikel blog & quotes',
      'Sesi peer chat 30 menit',
    ],
    color: Colors.white,
    textColor: Colors.black,
    buttonColor: Colors.grey,
    buttonText: 'Paket Saat Ini',
    isCurrent: true,
  ),
  const Package(
    title: 'Premium',
    price: 'Rp 49.000',
    period: '/bulan',
    features: [
      'Semua fitur Free',
      'Priority matching (skip queue)',
      'Sesi peer chat 60 menit',
      'Konten rekomendasi personal',
      'Tanpa iklan',
    ],
    color: Color(0xFF3A9D76),
    textColor: Colors.white,
    buttonColor: Color(0xFFE87C55),
    buttonText: 'Berlangganan',
  ),
  const Package(
    title: 'Premium+',
    price: 'Rp 149.000',
    period: '/bulan',
    features: [
      'Semua fitur Premium',
      '✨ 2 sesi konsultasi profesional',
      'Save chat transcripts',
      'Early access fitur baru',
      'Badge "Premium Member"',
    ],
    color: Color(0xFF4A90E2),
    textColor: Colors.white,
    buttonColor: Colors.white,
    buttonTextColor: Color(0xFF4A90E2),
    buttonText: 'Berlangganan Premium+',
    isRecommended: true,
  ),
];
