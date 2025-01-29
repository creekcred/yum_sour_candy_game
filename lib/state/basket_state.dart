import 'package:flutter/material.dart';

/// 🏀 **Basket State - Handles Player's Basket Movement & Upgrades**
class BasketState with ChangeNotifier {
  double basketX = 0.5; // 📍 Basket Position (0.0 - 1.0, Center)
  int basketLevel = 1; // 🏆 Basket Upgrade Level

  /// 🎮 **Move Basket Left or Right**
  void moveBasket(double dx) {
    basketX = (basketX + dx).clamp(0.05, 0.95);
    notifyListeners();
  }

  /// 🔼 **Upgrade Basket**
  void upgradeBasket() {
    if (basketLevel < 5) {
      basketLevel++;
      notifyListeners();
    }
  }
}
