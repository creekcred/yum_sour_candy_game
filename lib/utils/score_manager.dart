import 'package:shared_preferences/shared_preferences.dart';

/// 🏆 **Score Manager - Handles Score Tracking & High Scores**
class ScoreManager {
  static const String _highScoreKey = "high_score";

  static Future<void> saveHighScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    int currentHighScore = await getHighScore();
    if (score > currentHighScore) {
      await prefs.setInt(_highScoreKey, score);
    }
  }

  static Future<int> getHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_highScoreKey) ?? 0;
  }
}
