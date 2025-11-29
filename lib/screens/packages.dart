import 'package:flutter/material.dart';

class PackagesScreen extends StatelessWidget {
  const PackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Paket Berlangganan',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Investasi untuk\nKesehatan Mentalmu',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Pilih paket yang sesuai dengan kebutuhanmu untuk mendapatkan akses penuh ke fitur eksklusif.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),

            // Free Package
            const PackageCard(
              title: 'Basic',
              price: 'Gratis',
              features: [
                'Akses ke Ruang Bercerita',
                'Akses ke Ruang Afirmasi',
                'Baca Artikel Blog',
              ],
              color: Colors.white,
              textColor: Colors.black,
              buttonColor: Colors.grey,
              buttonText: 'Saat Ini',
              isCurrent: true,
            ),
            const SizedBox(height: 24),

            // Premium Package
            const PackageCard(
              title: 'Premium',
              price: 'Rp 49.000',
              period: '/bulan',
              features: [
                'Semua fitur Basic',
                'Akses Prioritas Mentor',
                'Konseling 1x sebulan',
                'Tanpa Iklan',
              ],
              color: Color(0xFF3A9D76),
              textColor: Colors.white,
              buttonColor: Color(0xFFE87C55),
              buttonText: 'Berlangganan',
              isRecommended: true,
            ),
            const SizedBox(height: 24),

            // Professional Package
            const PackageCard(
              title: 'Professional',
              price: 'Rp 149.000',
              period: '/bulan',
              features: [
                'Semua fitur Premium',
                'Konseling Mingguan',
                'Webinar Eksklusif',
                'Laporan Kesehatan Mental',
              ],
              color: Colors.white,
              textColor: Colors.black,
              buttonColor: Color(0xFF3A9D76),
              buttonText: 'Berlangganan',
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class PackageCard extends StatelessWidget {
  final String title;
  final String price;
  final String? period;
  final List<String> features;
  final Color color;
  final Color textColor;
  final Color buttonColor;
  final String buttonText;
  final bool isCurrent;
  final bool isRecommended;

  const PackageCard({
    super.key,
    required this.title,
    required this.price,
    this.period,
    required this.features,
    required this.color,
    required this.textColor,
    required this.buttonColor,
    required this.buttonText,
    this.isCurrent = false,
    this.isRecommended = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
            border: isRecommended
                ? Border.all(color: const Color(0xFFE87C55), width: 2)
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: textColor,
                    ),
                  ),
                  if (period != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6, left: 4),
                      child: Text(
                        period!,
                        style: TextStyle(
                          fontSize: 14,
                          color: textColor.withOpacity(0.7),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),
              ...features.map((feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: isRecommended ? Colors.white : Colors.green,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          feature,
                          style: TextStyle(
                            color: textColor.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isCurrent
                      ? null
                      : () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Berlangganan'),
                              content: Text(
                                  'Anda akan berlangganan paket $title seharga $price${period ?? ""}'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Batal'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Berhasil berlangganan! (Mock)')),
                                    );
                                  },
                                  child: const Text('Konfirmasi'),
                                ),
                              ],
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBackgroundColor: Colors.grey[300],
                    disabledForegroundColor: Colors.grey[600],
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isRecommended)
          Positioned(
            top: -12,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFE87C55),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Rekomendasi',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
