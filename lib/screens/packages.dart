import 'package:flutter/material.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  int _selectedPackageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paket Konsultasi'),
        backgroundColor: Colors.green.shade500,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Choose of Mental Health\nConsultation Packages for\nYour Needs',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 32),
            // Basic Package
            GestureDetector(
              onTap: () {
                setState(() => _selectedPackageIndex = 0);
              },
              child: PriceCard(
                title: 'Basic',
                price: '\$69.99',
                period: '/Month',
                description: 'Lorem ipsum dolor sit amet consectetur.',
                isActive: _selectedPackageIndex == 0,
                onSeePrice: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Basic Package Selected')),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Standard Package
            GestureDetector(
              onTap: () {
                setState(() => _selectedPackageIndex = 1);
              },
              child: PriceCard(
                title: 'Standard',
                price: '\$79.99',
                period: '/Month',
                description: 'Lorem ipsum dolor sit amet consectetur.',
                isActive: _selectedPackageIndex == 1,
                onSeePrice: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Standard Package Selected')),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Premium Package
            GestureDetector(
              onTap: () {
                setState(() => _selectedPackageIndex = 2);
              },
              child: PriceCard(
                title: 'Premium',
                price: '\$89.99',
                period: '/Month',
                description: 'Lorem ipsum dolor sit amet consectetur.',
                isActive: _selectedPackageIndex == 2,
                onSeePrice: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Premium Package Selected')),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            // Footer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.green.shade500,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.health_and_safety,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Memberdayakan Melalui Cerita',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
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

class PriceCard extends StatefulWidget {
  final String title;
  final String price;
  final String period;
  final String description;
  final bool isActive;
  final VoidCallback onSeePrice;

  const PriceCard({
    super.key,
    required this.title,
    required this.price,
    required this.period,
    required this.description,
    required this.isActive,
    required this.onSeePrice,
  });

  @override
  State<PriceCard> createState() => _PriceCardState();
}

class _PriceCardState extends State<PriceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _isHovered || widget.isActive
        ? Colors.green.shade200
        : Colors.white;
    final borderColor = _isHovered || widget.isActive
        ? Colors.green.shade400
        : Colors.grey.shade300;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: widget.price,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade600,
                            ),
                          ),
                          TextSpan(
                            text: widget.period,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (widget.isActive)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.green.shade500,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20,
                    ),
                  )
                else
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onSeePrice,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade400,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'See pricing',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
