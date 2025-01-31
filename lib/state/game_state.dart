import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:yum_sour_candy_game/screens/game_over_screen.dart';

class FallingItem {
  double x;
  double y;
  double dx;
  double dy;
  String type;
  bool markForRemoval = false;

  FallingItem({
    required this.x,
    required this.y,
    required this.dx,
    required this.dy,
    required this.type,
  });
}

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

  // Vibration Settings
  bool _vibrationEnabled = true;

  bool get vibrationEnabled => _vibrationEnabled;

  void setVibration(bool value) {
    _vibrationEnabled = value;
    debugPrint("[GameState] Vibration: ${_vibrationEnabled ? 'ON' : 'OFF'}");
    notifyListeners();
  }

  // Countdown Variables
  bool isCountdownActive = false;
  String countdownText = "Ready";
  Timer? _countdownTimer;

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
    debugPrint("[GameState] Sound: ${_soundEnabled ? 'ON' : 'OFF'}");
    notifyListeners();
  }

  void setMusic(bool value) {
    _musicEnabled = value;
    debugPrint("[GameState] Music: ${_musicEnabled ? 'ON' : 'OFF'}");
    notifyListeners();
  }

  void setDifficulty(String value) {
    _difficulty = value;
    debugPrint("[GameState] Difficulty set to: $_difficulty");
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _darkMode = value;
    debugPrint("[GameState] Dark Mode: ${_darkMode ? 'ENABLED' : 'DISABLED'}");
    notifyListeners();
  }

  void resetProgress() {
    _soundEnabled = true;
    _musicEnabled = true;
    _difficulty = "Medium";
    _darkMode = false;
    debugPrint("[GameState] Reset progress to defaults.");
    notifyListeners();
  }

  // Game Over Callback
  Function(int score)? gameOverCallback;

  void startCountdown(VoidCallback? onCountdownComplete) {
    isCountdownActive = true;
    int count = 3;
    countdownText = "Ready";
    debugPrint("[GameState] Countdown Started");

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count > 0) {
        countdownText = count.toString();
        debugPrint("[GameState] Countdown: $count");
        count--;
      } else if (count == 0) {
        countdownText = "GO!";
        debugPrint("[GameState] Countdown: GO!");
        count--;
      } else {
        timer.cancel();
        isCountdownActive = false;
        countdownText = "";
        _countdownTimer?.cancel();
        if (onCountdownComplete != null) {
          onCountdownComplete();
        }
      }
      notifyListeners();
    });
  }

  /// 🎮 **Start Game Timer**
  void startGameTimer(BuildContext context) {
    gameTimer?.cancel();
    debugPrint("[GameState] Game Timer Started");
    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isPaused) {
        debugPrint("[GameState] Game Timer Paused");
        return;
      }

      if (timeLeft > 0) {
        timeLeft--;
        debugPrint("[GameState] Time Left: $timeLeft");
        notifyListeners();
      } else {
        timer.cancel();
        _showGameOver(context);
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

    debugPrint("[GameState] Spawned Item: Type=$itemType at X=$spawnX");

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
    debugPrint("[GameState] Collision with: $itemType");
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
        debugPrint("[GameState] Unknown item type: $itemType");
    }
    notifyListeners();
  }

  /// 🚀 **Level Up Basket**
  void _levelUpBasket() {
    score += 50;
    collectedSpecialItems = 0;
    basketLevel = (basketLevel < 5) ? basketLevel + 1 : 5;
    debugPrint("[GameState] Basket Leveled Up! New Level: $basketLevel");
    notifyListeners();
  }

  /// 🎮 **Move Basket**
  void moveBasket(double dx, double dy) {
    basketX = (basketX + dx).clamp(0.05, 0.95);
    basketY = (basketY + dy).clamp(0.7, 0.95);
    debugPrint("[GameState] Basket moved to: X=$basketX, Y=$basketY");
    notifyListeners();
  }

  /// 🕹️ **Pause & Resume Game**
  void pauseGame() {
    isPaused = true;
    gameTimer?.cancel();
    debugPrint("[GameState] Game Paused");
    notifyListeners();
  }

  void resumeGame(BuildContext context) {
    isPaused = false;
    startGameTimer(context);
    debugPrint("[GameState] Game Resumed");
    notifyListeners();
  }

  /// 🚪 **Game Over**
  void _showGameOver(BuildContext context) {
    debugPrint("[GameState] Game Over - Final Score: $score");
    gameOverCallback?.call(score);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => GameOverScreen(finalScore: score),
      ),
    );
  }
}
