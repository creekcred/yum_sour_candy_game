import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../components/falling_item.dart';

/// 🎮 **Game State Management**
/// - Handles game logic, falling items, basket movement, score, and collision detection.
class GameState with ChangeNotifier {
  int timeLeft = 60; // ⏳ Game Timer (Seconds)
  int score = 0; // 🏆 Player's Score
  bool isPaused = false; // ⏸️ Pause State
  Timer? gameTimer; // ⏰ Main Game Timer

  // 🎯 **Basket Properties**
  double basketX = 0.5; // 📍 Basket Position (X)
  double basketY = 0.85; // 📍 Basket Position (Y)
  int basketLevel = 1; // 🏆 Basket Upgrade Level

  // 🍬 **Falling Items**
  List<FallingItem> fallingItems = [];
  final Random _random = Random();

  // 🎯 **Special Items Tracking**
  int collectedSpecialItems = 0;
  final int specialItemGoal = 3; // 🎯 Collect 3 to Level Up

  /// 🎮 **Start Game Timer**
  void startGameTimer() {
    gameTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (isPaused) return;

      if (timeLeft > 0) {
        if (timeLeft % 2 == 0) {
          spawnFallingItem(); // 🍬 Drop new items every 2 seconds
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

  /// 🚀 **Spawn Falling Items**
  void spawnFallingItem() {
    double spawnX = _random.nextDouble(); // Random X position
    List<String> itemTypes = ["sour_candy", "bitter_candy", "special"];
    String itemType = itemTypes[_random.nextInt(itemTypes.length)];

    fallingItems.add(FallingItem(
      x: spawnX,
      y: 0,
      type: itemType,
    ));
    notifyListeners();
  }

  /// ⬇️ **Update Falling Items**
  void updateFallingItems() {
    for (var item in fallingItems) {
      item.fall(); // ✅ Apply falling motion

      // 🏀 **Check if Basket Catches Item**
      if ((item.y >= basketY) && ((item.x - basketX).abs() < 0.1)) {
        handleCollision(item);
      }
    }

    // 🗑️ Remove Items That Fall Off Screen
    fallingItems.removeWhere((item) => item.y > 1);
    notifyListeners();
  }

  /// 🎯 **Handle Item Collection**
  void handleCollision(FallingItem item) {
    if (item.y >= basketY && (item.x - basketX).abs() < 0.1) {
      // 🍬 Award points based on item type
      if (item.type == "sour_candy") {
        score += 10;
      } else if (item.type == "bitter_candy") {
        score -= 5;
      } else if (item.type == "special") {
        score += 50;
        collectedSpecialItems++;
        if (collectedSpecialItems >= specialItemGoal) {
          _levelUpBasket(); // 🎯 Level Up Basket
        }
      }

      fallingItems.remove(item);
      notifyListeners();
    }
  }

  /// 🚀 **Level Up Basket**
  void _levelUpBasket() {
    score += 50;
    collectedSpecialItems = 0;
    basketLevel = (basketLevel < 5) ? basketLevel + 1 : 5;
    notifyListeners();
  }

  /// 🎮 **Move Basket (Touch & Keyboard)**
  void moveBasket(double dx) {
    basketX = (basketX + dx).clamp(0.05, 0.95);
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
    basketLevel = 1;
    fallingItems.clear();
    startGameTimer();
    notifyListeners();
  }
}
