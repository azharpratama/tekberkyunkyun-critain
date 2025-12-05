class UserStats {
  final int listeningSessionsCompleted;
  final int speakingSessionsCompleted;
  final int totalPoints;
  final String badgeLevel; // 'none', 'bronze', 'silver', 'gold'
  final int peopleHelped;

  const UserStats({
    this.listeningSessionsCompleted = 0,
    this.speakingSessionsCompleted = 0,
    this.totalPoints = 0,
    this.badgeLevel = 'none',
    this.peopleHelped = 0,
  });

  UserStats copyWith({
    int? listeningSessionsCompleted,
    int? speakingSessionsCompleted,
    int? totalPoints,
    String? badgeLevel,
    int? peopleHelped,
  }) {
    return UserStats(
      listeningSessionsCompleted:
          listeningSessionsCompleted ?? this.listeningSessionsCompleted,
      speakingSessionsCompleted:
          speakingSessionsCompleted ?? this.speakingSessionsCompleted,
      totalPoints: totalPoints ?? this.totalPoints,
      badgeLevel: badgeLevel ?? this.badgeLevel,
      peopleHelped: peopleHelped ?? this.peopleHelped,
    );
  }

  String getBadgeEmoji() {
    switch (badgeLevel) {
      case 'bronze':
        return '🥉';
      case 'silver':
        return '🥈';
      case 'gold':
        return '🥇';
      default:
        return '';
    }
  }

  int getSessionsForNextBadge() {
    if (listeningSessionsCompleted < 10) return 10;
    if (listeningSessionsCompleted < 25) return 25;
    if (listeningSessionsCompleted < 50) return 50;
    return 50; // Max
  }

  String getNextBadgeLevel() {
    if (listeningSessionsCompleted < 10) return 'Bronze';
    if (listeningSessionsCompleted < 25) return 'Silver';
    if (listeningSessionsCompleted < 50) return 'Gold';
    return 'Gold'; // Max
  }

  double getBadgeProgress() {
    int target = getSessionsForNextBadge();
    return listeningSessionsCompleted / target;
  }

  // Calculate badge level based on sessions
  static String calculateBadgeLevel(int sessions) {
    if (sessions >= 50) return 'gold';
    if (sessions >= 25) return 'silver';
    if (sessions >= 10) return 'bronze';
    return 'none';
  }
}

// Mock service for managing user stats
class UserStatsService {
  static UserStats _currentStats = const UserStats();

  static UserStats get currentStats => _currentStats;

  static void completeListeningSession() {
    final newListeningSessions = _currentStats.listeningSessionsCompleted + 1;
    _currentStats = _currentStats.copyWith(
      listeningSessionsCompleted: newListeningSessions,
      totalPoints: _currentStats.totalPoints + 10,
      peopleHelped: _currentStats.peopleHelped + 1,
      badgeLevel: UserStats.calculateBadgeLevel(newListeningSessions),
    );
  }

  static void completeSpeakingSession() {
    _currentStats = _currentStats.copyWith(
      speakingSessionsCompleted: _currentStats.speakingSessionsCompleted + 1,
      totalPoints: _currentStats.totalPoints + 5,
    );
  }

  static void reset() {
    _currentStats = const UserStats();
  }
}
