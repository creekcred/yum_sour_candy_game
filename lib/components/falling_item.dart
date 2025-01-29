import 'package:flutter/material.dart';

/// 🍬 **FallingItem Class** - Defines falling candy objects
class FallingItem {
  double x; // 📍 Horizontal position (0.0 - 1.0)
  double y; // 📍 Vertical position (0.0 - 1.0, falling down)
  final String type; // 🍬 Candy Type: "sour_candy", "bitter_candy", etc.
  final double speed; // ⏬ Falling speed
  String imagePath; // 🖼️ Path to candy image

  FallingItem({
    required this.x,
    required this.y,
    required this.type,
    this.speed = 0.02, // ✅ Default falling speed
  }) : imagePath = _getImagePath(type); // 🎭 Load the correct sprite image

  /// 🎭 **Get Image Path Based on Type**
  static String _getImagePath(String type) {
    switch (type) {
      case "sour_candy":
        return "assets/sprites/themes/default/sour_candy/sour_candy.png";
      case "bitter_candy":
        return "assets/sprites/themes/default/bitter_candy/bitter_candy.png";
      case "special":
        return "assets/sprites/themes/default/powerups/special_item.png";
      default:
        return "assets/sprites/themes/default/sour_candy/sour_candy.png"; // ✅ Default fallback
    }
  }

  /// ⏬ **Move the candy down the screen**
  void fall() {
    y += speed; // ✅ Move down based on speed
  }
}
