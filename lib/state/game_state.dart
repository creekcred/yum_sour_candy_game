import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/game_state.dart';
import 'dart:async';
import 'dart:math';

class GameState extends ChangeNotifier {
  // 🕹️ Game State Variables
  int timeLeft = 60;
  int score = 0;
  int basketLevel = 1;
  int collectedSpecialItems = 0;
  int specialItemGoal = 3;
  bool isPaused = false;
  double basketX = 0.5;
  double basketY = 0.9;
  List<FallingItem> fallingItems = [];
  Timer? gameTimer;
  final Random _random = Random();

  bool _vibrationEnabled = true; // Default ON

  bool get vibrationEnabled => _vibrationEnabled;

  void setVibration(bool value) {
    _vibrationEnabled = value;
    notifyListeners();
  }

  // Countdown Variables
  bool isCountdownActive = false;
  String countdownText = "3";

  // 🎵 Settings Variables
  bool _soundEnabled = true;
  bool _musicEnabled = true;
  String _difficulty = "Medium";
  bool _darkMode = false;

  // ✅ Getters
  bool get soundEnabled => _soundEnabled;
  bool get musicEnabled => _musicEnabled;
  String get difficulty => _difficulty;
  bool get darkMode => _darkMode;

  // ✅ Setters
  void setSound(bool value) {
    _soundEnabled = value;
    notifyListeners();
  }

  void setMusic(bool value) {
    _musicEnabled = value;
    notifyListeners();
  }

  void setDifficulty(String value) {
    _difficulty = value;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _darkMode = value;
    notifyListeners();
  }

  void resetProgress() {
    _soundEnabled = true;
    _musicEnabled = true;
    _difficulty = "Medium";
    _darkMode = false;
    notifyListeners();
  }

  /// 🎮 **Start Countdown**
  void startCountdown(VoidCallback? onCountdownComplete) {
    isCountdownActive = true;
    int count = 3;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count > 0) {
        countdownText = count.toString();
        count--;
      } else {
        timer.cancel();
        isCountdownActive = false;
        countdownText = "";
        if (onCountdownComplete != null) {
          onCountdownComplete();
        }
      }
      notifyListeners();
    });
  }

  /// 🎮 **Start Game Timer**
  void startGameTimer() {
    gameTimer?.cancel();
    gameTimer = Timer.periodic(const Duration(seconds: 60), (timer) {
      if (isPaused) return;
      if (timeLeft > 0) {
        if (timeLeft % 20 == 0) {
          spawnFallingItem();
        }
        updateFallingItems();
        timeLeft--;
        notifyListeners(); // Ensure UI updates
      } else {
        timer.cancel();
        _showGameOver();
      }
    });
  }

  /// 🚀 **Spawn Falling Items**
  void spawnFallingItem() {
    double spawnX = _random.nextDouble();
    List<String> itemTypes = ["sour_candy", "bitter_candy", "special"];
    String itemType = itemTypes[_random.nextInt(itemTypes.length)];
    double dx = (_random.nextDouble() - 0.5) * 0.02;
    double dy = _random.nextDouble() * 0.02 + 0.01;

    fallingItems.add(FallingItem(
      x: spawnX,
      y: 0,
      dx: dx,
      dy: dy,
      type: itemType,
    ));
    notifyListeners();
  }

  /// ⬇️ **Update Falling Items**
  void updateFallingItems() {
    for (var item in fallingItems) {
      item.x += item.dx;
      item.y += item.dy;
      if ((item.y >= basketY - 0.05) && ((item.x - basketX).abs() < 0.1)) {
        handleCollision(item.type);
        item.markForRemoval = true;
      }
      if (item.x <= 0 || item.x >= 1) {
        item.dx = -item.dx;
      }
    }
    fallingItems.removeWhere((item) => item.y > 1 || item.markForRemoval);
    notifyListeners();
  }

  /// 🎯 **Handle Collision**
  void handleCollision(String itemType) {
    switch (itemType) {
      case "sour_candy":
        score += 10;
        break;
      case "bitter_candy":
        score -= 5;
        break;
      case "special":
        collectedSpecialItems++;
        if (collectedSpecialItems >= specialItemGoal) {
          _levelUpBasket();
        }
        break;
      default:
        debugPrint("Unknown item type: $itemType");
    }
    notifyListeners();
  }

  /// 🚀 **Level Up Basket**
  void _levelUpBasket() {
    score += 50;
    collectedSpecialItems = 0;
    basketLevel = (basketLevel < 5) ? basketLevel + 1 : 5;
    notifyListeners();
  }

  /// 🎮 **Move Basket**
  void moveBasket(double dx, double dy) {
    basketX = (basketX + dx).clamp(0.05, 0.95);
    basketY = (basketY + dy).clamp(0.7, 0.95);
    notifyListeners();
  }

  /// 🕹️ **Pause & Resume Game**
  void pauseGame() {
    isPaused = true;
    gameTimer?.cancel();
    notifyListeners();
  }

  void resumeGame() {
    isPaused = false;
    startGameTimer();
    notifyListeners();
  }

  /// 🚪 **Game Over Placeholder**
  void _showGameOver() {
    debugPrint("Game Over - Final Score: $score");
  }

  /// 🔄 **Restart Game**
  void restartGame() {
    timeLeft = 60;
    score = 0;
    isPaused = false;
    basketX = 0.5;
    basketY = 0.9;
    basketLevel = 1;
    fallingItems.clear();
    startGameTimer();
    notifyListeners();
  }
}

/// 🍬 **FallingItem Class**
class FallingItem {
  final String type;
  double x;
  double y;
  double dx;
  double dy;
  bool markForRemoval = false;

  FallingItem({
    required this.type,
    required this.x,
    required this.y,
    required this.dx,
    required this.dy,
  });
}
