import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/affirmations.dart';
import '../services/ruang_afirmasi_service.dart';

class AffirmationViewModel extends ChangeNotifier {
  final _afirmasiService = RuangAfirmasiService();

  // Tab State
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  void setTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }

  // Receive Affirmation State
  List<Map<String, dynamic>> _affirmationsData = [];
  List<Affirmation> _affirmations = [];
  Set<String> _savedAffirmationIds = {};
  int _currentAffirmationIndex = 0;
  bool _isLoading = true;
  String? _errorMessage;

  List<Affirmation> get affirmations => _affirmations;
  int get currentAffirmationIndex => _currentAffirmationIndex;
  Affirmation? get currentAffirmation =>
      _affirmations.isNotEmpty ? _affirmations[_currentAffirmationIndex] : null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AffirmationViewModel() {
    loadAffirmations();
  }

  Future<void> loadAffirmations() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final data = await _afirmasiService.getAffirmations();
      _affirmationsData = data;
      _savedAffirmationIds = await _afirmasiService.getSavedAffirmationIds();

      if (data.isEmpty) {
        // Fallback to default affirmations if database is empty
        _affirmations = defaultAffirmations;
      } else {
        // Convert Supabase data to Affirmation objects
        _affirmations = data.map((item) {
          return Affirmation(
            text: item['content'] as String,
            color: _getCategoryColor(item['category'] as String),
          );
        }).toList();
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Gagal memuat afirmasi: $e';
      _affirmations = defaultAffirmations; // Fallback to defaults
      _isLoading = false;
      notifyListeners();
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'self-love':
        return Colors.pink[100]!;
      case 'motivation':
        return Colors.orange[100]!;
      case 'self-acceptance':
        return Colors.blue[100]!;
      case 'support':
        return Colors.green[100]!;
      case 'hope':
        return Colors.purple[100]!;
      default:
        return Colors.amber[100]!;
    }
  }

  void setAffirmationIndex(int index) {
    if (_affirmations.isEmpty) return;
    _currentAffirmationIndex = index % _affirmations.length;
    notifyListeners();
  }

  void shuffleAffirmation() {
    if (_affirmations.isEmpty) return;
    final random = Random();
    final newIndex = random.nextInt(_affirmations.length);
    _currentAffirmationIndex = newIndex;
    notifyListeners();
  }

  String? _getCurrentAffirmationId() {
    if (_affirmationsData.isEmpty ||
        _currentAffirmationIndex >= _affirmationsData.length) {
      return null;
    }
    return _affirmationsData[_currentAffirmationIndex]['id'] as String?;
  }

  bool isCurrentAffirmationSaved() {
    final id = _getCurrentAffirmationId();
    if (id == null) return false;
    return _savedAffirmationIds.contains(id);
  }

  Future<void> toggleSaveCurrentAffirmation() async {
    final id = _getCurrentAffirmationId();
    if (id == null) return;

    try {
      if (isCurrentAffirmationSaved()) {
        await _afirmasiService.unsaveAffirmation(id);
        _savedAffirmationIds.remove(id);
      } else {
        await _afirmasiService.saveAffirmation(id);
        _savedAffirmationIds.add(id);
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error toggling save: $e');
    }
  }

  Future<void> copyCurrentAffirmation() async {
    if (currentAffirmation == null) return;
    await Clipboard.setData(ClipboardData(text: currentAffirmation!.text));
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

  /// Send affirmation to database
  Future<bool> sendAffirmation() async {
    if (!canSend()) return false;

    try {
      final success = await _afirmasiService.createAffirmation(
        content: _messageText.trim(),
      );

      if (success) {
        clearMessage();
        // Reload affirmations to include the new one
        await loadAffirmations();
      }

      return success;
    } catch (e) {
      debugPrint('Error sending affirmation: $e');
      return false;
    }
  }
}
