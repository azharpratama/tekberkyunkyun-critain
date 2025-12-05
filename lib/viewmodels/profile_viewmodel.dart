import 'package:flutter/material.dart';
import '../models/user_stats.dart';

class ProfileViewModel extends ChangeNotifier {
  // User Stats
  UserStats _stats = UserStatsService.currentStats;
  UserStats get stats => _stats;

  void refreshStats() {
    _stats = UserStatsService.currentStats;
    notifyListeners();
  }

  // Profile Data (Mock)
  final String _username = 'Pengguna Setia';
  final String _email = 'user@example.com';
  final String _avatarUrl = ''; // Empty for default icon

  String get username => _username;
  String get email => _email;
  String get avatarUrl => _avatarUrl;

  // Settings Actions
  void logout(BuildContext context) {
    // Implement logout logic here (e.g., clear tokens, navigate to login)
    Navigator.pushReplacementNamed(context, '/login');
  }

  void navigateToEditProfile(BuildContext context) {
    // Navigate to edit profile screen
  }

  void navigateToSettings(BuildContext context) {
    // Navigate to settings screen
  }
}
