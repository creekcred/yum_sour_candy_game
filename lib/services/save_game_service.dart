import 'package:shared_preferences/shared_preferences.dart';

/// 💾 **Save Game Service - Stores & Retrieves Game Progress**
class SaveGameService {
  static const String _scoreKey = "high_score";
  static const String _levelKey = "player_level";

  /// 📝 **Save High Score**
  static Future<void> saveHighScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_scoreKey, score);
  }

  /// 🏆 **Get High Score**
  static Future<int> getHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_scoreKey) ?? 0;
  }

  /// 🔄 **Save Player Level**
  static Future<void> savePlayerLevel(int level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_levelKey, level);
  }

  /// 📥 **Load Player Level**
  static Future<int> getPlayerLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_levelKey) ?? 1;
  }
}
