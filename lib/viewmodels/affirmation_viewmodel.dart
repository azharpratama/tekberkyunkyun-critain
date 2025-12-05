import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/affirmations.dart';
import '../services/saved_affirmations_service.dart';

class AffirmationViewModel extends ChangeNotifier {
  // Tab State
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  void setTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }

  // Receive Affirmation State
  final List<Affirmation> _affirmations = defaultAffirmations;
  int _currentAffirmationIndex = 0;

  List<Affirmation> get affirmations => _affirmations;
  int get currentAffirmationIndex => _currentAffirmationIndex;
  Affirmation get currentAffirmation => _affirmations[_currentAffirmationIndex];

  void setAffirmationIndex(int index) {
    _currentAffirmationIndex = index % _affirmations.length;
    notifyListeners();
  }

  void shuffleAffirmation() {
    final random = Random();
    final newIndex = random.nextInt(_affirmations.length);
    // Ensure we jump to a new page effectively if using PageView logic externally
    // But for VM state, just setting the index is enough.
    // The View might need to handle the animation controller logic.
    _currentAffirmationIndex = newIndex;
    notifyListeners();
  }

  bool isCurrentAffirmationSaved() {
    return SavedAffirmationsService.isSaved(currentAffirmation.text);
  }

  void toggleSaveCurrentAffirmation() {
    if (isCurrentAffirmationSaved()) {
      SavedAffirmationsService.removeAffirmation(currentAffirmation.text);
    } else {
      SavedAffirmationsService.saveAffirmation(currentAffirmation.text);
    }
    notifyListeners();
  }

  Future<void> copyCurrentAffirmation() async {
    await Clipboard.setData(ClipboardData(text: currentAffirmation.text));
  }

  // Send Affirmation State
  String _messageText = '';
  String get messageText => _messageText;
  int get charCount => _messageText.length;
  static const int maxChars = 200;

  void updateMessage(String text) {
    _messageText = text;
    notifyListeners();
  }

  void appendTemplate(String template) {
    _messageText += template;
    notifyListeners();
  }

  void clearMessage() {
    _messageText = '';
    notifyListeners();
  }

  bool canSend() {
    return _messageText.trim().isNotEmpty;
  }
}
