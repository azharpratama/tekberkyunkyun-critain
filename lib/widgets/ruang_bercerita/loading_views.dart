import 'package:flutter/material.dart';
import '../animations/pulsing_avatar.dart';

class SearchingView extends StatelessWidget {
  const SearchingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const PulsingAvatar(
            icon: Icons.search,
            color: Color(0xFF3A9D76),
          ),
          const SizedBox(height: 32),
          const Text(
            'Mencari Teman Bercerita...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3A9D76),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Mohon tunggu sebentar ya',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

class WaitingView extends StatelessWidget {
  const WaitingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const PulsingAvatar(
            icon: Icons.hearing,
            color: Color(0xFF3A9D76),
          ),
          const SizedBox(height: 32),
          const Text(
            'Menunggu Pencari Cerita...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3A9D76),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Kami sedang menghubungkanmu',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
