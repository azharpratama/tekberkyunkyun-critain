import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../core/constants/app_assets.dart';
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
  String _username = 'Pengguna Setia';
  String _email = 'user@example.com';
  String _avatarUrl = ''; // Empty for default icon
  File? _selectedImage;

  String get username => _username;
  String get email => _email;
  String get avatarUrl => _avatarUrl;
  File? get selectedImage => _selectedImage;

  ImageProvider get profileImage {
    if (_selectedImage != null) {
      return FileImage(_selectedImage!);
    } else if (_avatarUrl.isNotEmpty) {
      return NetworkImage(_avatarUrl);
    }
    return const AssetImage(AppAssets.profilePlaceholder);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  void updateProfile({required String name, required String email}) {
    _username = name;
    _email = email;
    notifyListeners();
  }

  void updatePassword(String password) {
    // In a real app, this would make an API call
    print('Password updated to: $password');
  }

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
