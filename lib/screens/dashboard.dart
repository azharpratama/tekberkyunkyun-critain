import 'package:flutter/material.dart';
// Import semua layar target
import 'mentor_screen.dart';
import 'team_screen.dart';
import 'maps_screen.dart';
import 'testimonials_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.title});
  final String title;

  // Widget pembantu untuk membuat tombol navigasi
  Widget _buildNavButton(BuildContext context, String title, Widget targetScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          // Navigasi menggunakan MaterialPageRoute
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetScreen),
          );
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50), // Tombol lebar penuh
          textStyle: const TextStyle(fontSize: 18),
        ),
        child: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch, // Agar tombol melebar
            children: <Widget>[
              const Text(
                'Pilih Halaman:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              
              // 1. Tombol Mentor
              _buildNavButton(context, '1. Mentor', const MentorScreen()),
              
              // 2. Tombol Team
              _buildNavButton(context, '2. Team', const TeamScreen()),
              
              // 3. Tombol Maps
              _buildNavButton(context, '3. Maps', const MapsScreen()),
              
              // 4. Tombol Testimonials
              _buildNavButton(context, '4. Testimonials', const TestimonialsScreen()),
            ],
          ),
        ),
      ),
    );
  }
}
