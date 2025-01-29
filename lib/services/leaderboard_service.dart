import 'package:flutter/foundation.dart';

/// 🏆 **Leaderboard Service - Manages Score Submissions & Rankings**
class LeaderboardService {
  static final List<Map<String, dynamic>> _leaderboard = [];

  /// 📝 **Submit Score**
  static void submitScore(String playerName, int score) {
    _leaderboard.add({"player": playerName, "score": score});
    _leaderboard.sort((a, b) => b["score"].compareTo(a["score"]));

    debugPrint("🏆 Leaderboard Updated: $_leaderboard");
  }

  /// 🔝 **Get Top Players**
  static List<Map<String, dynamic>> getTopPlayers({int topN = 5}) {
    return _leaderboard.take(topN).toList();
  }
}
