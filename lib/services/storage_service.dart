import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class StorageService {
  final _supabase = Supabase.instance.client;

  /// Upload avatar and return public URL
  Future<String?> uploadAvatar(File imageFile) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      // Delete existing avatar first
      await deleteAvatar();

      final fileExt = path.extension(imageFile.path);
      final fileName = 'avatar$fileExt';
      final filePath = '$userId/$fileName';

      await _supabase.storage.from('avatars').upload(
            filePath,
            imageFile,
            fileOptions: const FileOptions(
              cacheControl: '3600',
              upsert: true,
            ),
          );

      final publicUrl =
          _supabase.storage.from('avatars').getPublicUrl(filePath);
      return publicUrl;
    } catch (e) {
      debugPrint('Error uploading avatar: $e');
      return null;
    }
  }

  /// Delete user's avatar
  Future<void> deleteAvatar() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      final files = await _supabase.storage.from('avatars').list(path: userId);

      if (files.isNotEmpty) {
        final filePaths = files.map((file) => '$userId/${file.name}').toList();
        await _supabase.storage.from('avatars').remove(filePaths);
      }
    } catch (e) {
      debugPrint('Error deleting avatar: $e');
    }
  }

  /// Upload story cover and return public URL
  Future<String?> uploadStoryCover(File imageFile, String storyId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final fileExt = path.extension(imageFile.path);
      final fileName = '${storyId}_cover$fileExt';
      final filePath = '$userId/$fileName';

      await _supabase.storage.from('story-covers').upload(
            filePath,
            imageFile,
            fileOptions: const FileOptions(
              cacheControl: '3600',
              upsert: true,
            ),
          );

      final publicUrl =
          _supabase.storage.from('story-covers').getPublicUrl(filePath);
      return publicUrl;
    } catch (e) {
      debugPrint('Error uploading story cover: $e');
      return null;
    }
  }

  /// Delete story cover
  Future<void> deleteStoryCover(String storyId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      final files =
          await _supabase.storage.from('story-covers').list(path: userId);

      final coverFile = files.firstWhere(
        (file) => file.name.startsWith(storyId),
        orElse: () => throw Exception('Cover not found'),
      );

      await _supabase.storage
          .from('story-covers')
          .remove(['$userId/${coverFile.name}']);
    } catch (e) {
      debugPrint('Error deleting story cover: $e');
    }
  }

  /// Pick image from gallery
  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  /// Pick image from camera
  Future<File?> takePhoto() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}
