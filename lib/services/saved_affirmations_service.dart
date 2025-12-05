// Simple service to manage saved affirmations
class SavedAffirmationsService {
  static final List<String> _savedAffirmations = [];

  static List<String> get savedAffirmations =>
      List.unmodifiable(_savedAffirmations);

  static void saveAffirmation(String text) {
    if (!_savedAffirmations.contains(text)) {
      _savedAffirmations.add(text);
    }
  }

  static void removeAffirmation(String text) {
    _savedAffirmations.remove(text);
  }

  static bool isSaved(String text) {
    return _savedAffirmations.contains(text);
  }

  static void clear() {
    _savedAffirmations.clear();
  }
}
