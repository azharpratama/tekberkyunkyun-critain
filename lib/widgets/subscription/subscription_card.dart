import 'package:flutter/material.dart';

class PackageCard extends StatelessWidget {
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

  const PackageCard({
    super.key,
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
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
            border: isRecommended
                ? Border.all(color: const Color(0xFFFFD700), width: 3)
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
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
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: textColor,
                    ),
                  ),
                  if (period != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8, left: 4),
                      child: Text(
                        period!,
                        style: TextStyle(
                          fontSize: 14,
                          color: textColor.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              Divider(
                color: textColor.withValues(alpha: 0.2),
              ),
              const SizedBox(height: 24),
              ...features.map((feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: textColor,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(
                              color: textColor.withValues(alpha: 0.9),
                              fontSize: 14,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isCurrent
                      ? null
                      : () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
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
                                          'Berhasil berlangganan! (Mock)',
                                        ),
                                      ),
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
                    foregroundColor: buttonTextColor ?? Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBackgroundColor: Colors.grey[300],
                    disabledForegroundColor: Colors.grey[600],
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFD700).withValues(alpha: 0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.white, size: 14),
                  SizedBox(width: 4),
                  Text(
                    'Paling Hemat',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
