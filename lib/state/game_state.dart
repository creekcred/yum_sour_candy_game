import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:yum_sour_candy_game/screens/game_over_screen.dart'; // Import the GameOverScreen widget

class GameState extends ChangeNotifier {
  // 🕹️ Game State Variables
  int timeLeft = 60; // Game timer in seconds
  int score = 0; // Player score
  int basketLevel = 1; // Basket level (1-5)
  int collectedSpecialItems = 0; // Special items collected
  int specialItemGoal = 3; // Special items needed to level up
  bool isPaused = false; // Pause state
  double basketX = 0.5; // Basket X position (0.0 to 1.0)
  double basketY = 0.9; // Basket Y position (0.0 to 1.0)
  List<FallingItem> fallingItems = []; // List of falling items
  Timer? gameTimer; // Game timer
  final Random _random = Random(); // Random number generator

  /// 🛠 **Initialize Game State**
  void initialize() {
    // Reset game state variables
    timeLeft = 60;
    score = 0;
    basketLevel = 1;
    collectedSpecialItems = 0;
    isPaused = false;
    basketX = 0.5;
    basketY = 0.9;
    fallingItems.clear();
    notifyListeners();
  }

  // Vibration Settings
  bool _vibrationEnabled = true; // Default ON

  bool get vibrationEnabled => _vibrationEnabled;

  void setVibration(bool value) {
    _vibrationEnabled = value;
    notifyListeners();
  }

  // Countdown Variables
  bool isCountdownActive = false;
  String countdownText = "Ready"; // Initial countdown text

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

  // Game Over Callback
  Function(int score)? gameOverCallback;

  void startCountdown(VoidCallback? onCountdownComplete) {
    isCountdownActive = true;
    int count = 3; // Start from 3
    countdownText = "Ready"; // Initial "Ready" message

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count > 0) {
        countdownText = count.toString(); // Display 3, 2, 1
        count--;
      } else if (count == 0) {
        countdownText = "GO!"; // Display "GO!"
        count--; // Move to the next state
      } else {
        timer.cancel();
        isCountdownActive = false;
        countdownText = ""; // Clear the countdown text
        if (onCountdownComplete != null) {
          onCountdownComplete(); // Start the game timer
        }
      }
      notifyListeners(); // Ensure UI updates
    });
  }

  /// 🎮 **Start Game Timer**
  void startGameTimer(BuildContext context) {
    gameTimer?.cancel(); // Prevent multiple timers
    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isPaused) return;

      if (timeLeft > 0) {
        timeLeft--; // Decrement timeLeft every second
        notifyListeners(); // Ensure UI updates
      } else {
        timer.cancel();
        _showGameOver(context); // Navigate to game over screen
      }
    });
  }

  /// 🚀 **Spawn Falling Items with Random Motion**
  void spawnFallingItem() {
    double spawnX = _random.nextDouble(); // Random X position
    List<String> itemTypes = ["sour_candy", "bitter_candy", "special"];
    String itemType = itemTypes[_random.nextInt(itemTypes.length)];

    // Random motion direction
    double dx = (_random.nextDouble() - 0.5) * 0.02; // Left/right movement
    double dy = _random.nextDouble() * 0.02 + 0.01; // Downward speed

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

      // 🏀 **Check if Basket Catches Item**
      if ((item.y >= basketY - 0.05) && ((item.x - basketX).abs() < 0.1)) {
        handleCollision(item.type);
        item.markForRemoval = true;
      }

      // 🔄 **Bounce Off Walls**
      if (item.x <= 0 || item.x >= 1) {
        item.dx = -item.dx;
      }
    }

    // 🗑️ Remove Items That Fall Off Screen or Are Marked for Removal
    fallingItems.removeWhere((item) => item.y > 1 || item.markForRemoval);
    notifyListeners();
  }

  /// 🎯 **Handle Collision When Candy Hits Basket**
  void handleCollision(String itemType) {
    switch (itemType) {
      case "sour_candy":
        score += 10; // Award points for sour candy
        break;
      case "bitter_candy":
        score -= 5; // Deduct points for bitter candy
        break;
      case "special":
        collectedSpecialItems++; // Collect special item
        if (collectedSpecialItems >= specialItemGoal) {
          _levelUpBasket(); // Level up basket if goal is reached
        }
        break;
      default:
        debugPrint("Unknown item type: $itemType");
    }
    notifyListeners();
  }

  /// 🚀 **Level Up Basket**
  void _levelUpBasket() {
    score += 50; // Bonus points for leveling up
    collectedSpecialItems = 0; // Reset special item counter
    basketLevel = (basketLevel < 5) ? basketLevel + 1 : 5; // Increase basket level (max 5)
    notifyListeners();
  }

  /// 🎮 **Move Basket**
  void moveBasket(double dx, double dy) {
    basketX = (basketX + dx).clamp(0.05, 0.95); // Clamp X position
    basketY = (basketY + dy).clamp(0.7, 0.95); // Clamp Y position
    notifyListeners();
  }

  /// 🕹️ **Pause & Resume Game**
  void pauseGame() {
    isPaused = true;
    gameTimer?.cancel();
    notifyListeners();
  }

  void resumeGame(BuildContext context) {
    isPaused = false;
    startGameTimer(context);
    notifyListeners();
  }

  /// 🚪 **Game Over Placeholder**
  void _showGameOver(BuildContext context) {
    debugPrint("Game Over - Final Score: $score");
    // Call the game over callback if it is set
    if (gameOverCallback != null) {
      gameOverCallback!(score);
    }
    // Navigate to the game over screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => GameOverScreen(finalScore: score),
      ),
    );
  }

  /// 🔄 **Restart Game**
  void restartGame(BuildContext context) {
    timeLeft = 60;
    score = 0;
    isPaused = false;
    basketX = 0.5;
    basketY = 0.9;
    basketLevel = 1;
    fallingItems.clear();
    startGameTimer(context);
    notifyListeners();
  }
}

/// 🍬 **FallingItem Class with Randomized Movement & Bouncing**
class FallingItem {
  final String type; // Item type (e.g., "sour_candy", "bitter_candy", "special")
  double x; // X position (0.0 to 1.0)
  double y; // Y position (0.0 to 1.0)
  double dx; // Movement in X direction
  double dy; // Movement in Y direction
  bool markForRemoval = false; // Mark for removal after collision

  FallingItem({
    required this.type,
    required this.x,
    required this.y,
    required this.dx,
    required this.dy,
  });
}
