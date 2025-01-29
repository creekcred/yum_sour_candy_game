import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

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

  // Countdown Variables
  bool isCountdownActive = false;
  String countdownText = "3"; // Default countdown value

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
          onCountdownComplete(); // Call the callback when countdown completes
        }
      }
      notifyListeners();
    });
  }

  /// 🎮 **Start Game Timer**
  void startGameTimer() {
    gameTimer?.cancel(); // Prevent multiple timers
    gameTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (isPaused) return;

      if (timeLeft > 0) {
        if (timeLeft % 20 == 0) {
          spawnFallingItem(); // 🍬 Drop new items every second
        }
        updateFallingItems();
        timeLeft--;
        notifyListeners();
      } else {
        timer.cancel();
        _showGameOver();
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

  void resumeGame() {
    isPaused = false;
    startGameTimer();
    notifyListeners();
  }

  /// 🚪 **Game Over Screen Placeholder**
  void _showGameOver() {
    debugPrint("Game Over - Final Score: $score");
    // TODO: Implement Game Over Navigation
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