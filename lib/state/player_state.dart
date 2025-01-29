import 'package:flutter/material.dart';

/// 🏆 **Player State - Manages Player Progress & Stats**
class PlayerState with ChangeNotifier {
  int totalScore = 0; // 🎯 Player's Total Score
  int gamesPlayed = 0; // 🎮 Number of Games Played

  /// 📊 **Update Score**
  void updateScore(int points) {
    totalScore += points;
    notifyListeners();
  }

  /// 🔄 **Reset Player Stats**
  void resetStats() {
    totalScore = 0;
    gamesPlayed = 0;
    notifyListeners();
  }
}
