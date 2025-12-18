import 'dart:io';
import 'package:flutter/material.dart';
import '../models/user_stats.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';
import '../core/constants/app_assets.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();

  // State
  UserStats _stats = const UserStats();
  String _username = '';
  String _email = '';
  String _avatarUrl = '';
  File? _selectedImage;
  bool _isLoading = false;
  bool _notificationEnabled = true;

  // Getters
  UserStats get stats => _stats;
  String get username => _username;
  String get email => _email;
  bool get isLoading => _isLoading;
  bool get notificationEnabled => _notificationEnabled;

  ImageProvider get profileImage {
    if (_selectedImage != null) {
      return FileImage(_selectedImage!);
    }
    if (_avatarUrl.isNotEmpty) {
      return NetworkImage(_avatarUrl);
    }
    return const AssetImage(AppAssets.profilePlaceholder);
  }

  ProfileViewModel() {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = _authService.currentUser;
      if (user != null) {
        _email = user.email ?? '';
        final profileData = await _authService.getProfile();
        if (profileData != null) {
          _username = profileData['display_name'] ?? '';
          _avatarUrl = profileData['avatar_url'] ?? '';

          // Map stats from profile data if available, otherwise default
          _stats = UserStats(
            totalPoints: profileData['total_points'] ?? 0,
            peopleHelped: profileData['people_helped'] ?? 0,
            badgeLevel: profileData['badge_level'] ?? 'none',
            listeningSessionsCompleted:
                profileData['listening_sessions_completed'] ?? 0,
            speakingSessionsCompleted:
                profileData['speaking_sessions_completed'] ?? 0,
          );
        }
      }
    } catch (e) {
      debugPrint('Error loading profile: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void refreshStats() {
    _loadProfile();
  }

  Future<void> pickImage() async {
    final file = await _storageService.pickImage();
    if (file != null) {
      _selectedImage = file;
      notifyListeners();
    }
  }

  Future<void> updateProfile(
      {required String name, required String email}) async {
    _isLoading = true;
    notifyListeners();

    try {
      String? newAvatarUrl;

      // Upload image if selected
      if (_selectedImage != null) {
        newAvatarUrl = await _storageService.uploadAvatar(_selectedImage!);
      }

      // Update Profile Table
      await _authService.updateProfile(
        displayName: name,
        avatarUrl: newAvatarUrl,
      );

      // Update Email if changed
      if (email != _email) {
        await _authService.updateEmail(email);
        _email = email;
      }

      _username = name;
      if (newAvatarUrl != null) {
        _avatarUrl = newAvatarUrl;
        _selectedImage = null; // Clear selected image
      }

      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePassword(String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _authService.updatePassword(password);
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleNotification(bool value) {
    _notificationEnabled = value;
    notifyListeners();
  }

  void logout(BuildContext context) async {
    await _authService.signOut();
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
