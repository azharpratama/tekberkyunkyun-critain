import 'package:flutter/material.dart';

const String _backgroundAsset = 'assets/maps_background.png';
const String _mapImageAsset = 'assets/map_placeholder.png';

class MapsScreen extends StatelessWidget {
  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color greenColor = Color(0xFF5AB664);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: const AssetImage(_backgroundAsset),
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Maps',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: greenColor,
                    ),
                  ),
                  const Text(
                    'Mapping Out Mental Health\nConsulting Strategies',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: greenColor,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 15,
                              offset: Offset(0, 5)),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                _mapImageAsset,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Center(
                              child: Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
