import 'package:flutter/material.dart'; // 📱 UI Components

/// ☀️ **Light Theme - Uses Defaults**
class LightTheme {
  static TextTheme get textTheme {
    return const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
      titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
    );
  }
}
