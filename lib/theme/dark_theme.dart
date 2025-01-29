import 'package:flutter/material.dart'; // 📱 UI Components

/// 🌙 **Dark Theme - Uses Defaults**
class DarkTheme {
  static TextTheme get textTheme {
    return const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
      titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white),
    );
  }
}
