import 'package:flutter/material.dart';

/// ⚡ **Power-Up State - Manages Active Power-Ups**
class PowerUpState with ChangeNotifier {
  bool isDoublePointsActive = false;
  bool isSlowTimeActive = false;

  /// 🔥 **Activate Double Points**
  void activateDoublePoints() {
    isDoublePointsActive = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 10), () {
      isDoublePointsActive = false;
      notifyListeners();
    });
  }

  /// ⏳ **Activate Slow Time**
  void activateSlowTime() {
    isSlowTimeActive = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 10), () {
      isSlowTimeActive = false;
      notifyListeners();
    });
  }
}
