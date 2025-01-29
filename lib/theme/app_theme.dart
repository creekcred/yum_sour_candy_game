import 'package:flutter/material.dart'; // 📱 UI Components
import '../utils/theme_manager.dart'; // 🎭 Dynamic Theme Handling
import 'dark_theme.dart'; // 🌙 Dark Theme
import 'light_theme.dart'; // ☀️ Light Theme

/// 🌈 **AppTheme Manager**
/// Provides dynamic light and dark themes based on the active seasonal theme.
class AppTheme {
  /// 🌞 **Light Theme** (Uses Default or Themed Colors)
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: ThemeManager.getPrimaryColor(), // 🎨 Dynamic Primary Color
      scaffoldBackgroundColor: Colors.transparent, // ✅ Transparent for Background Image
      textTheme: LightTheme.textTheme, // 🔤 Text Styles (Fixed Reference)
      fontFamily: ThemeManager.getFontFamily(), // 📝 Dynamic Font
      appBarTheme: AppBarTheme(
        backgroundColor: ThemeManager.getPrimaryColor(),
        foregroundColor: Colors.white, // 🔵 Default White Text
        elevation: 2,
      ),
    );
  }

  /// 🌙 **Dark Theme** (Uses Default or Themed Colors)
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: ThemeManager.getPrimaryColor(isDark: true), // 🎨 Dynamic Primary Color (Dark)
      scaffoldBackgroundColor: Colors.transparent, // ✅ Transparent for Background Image
      textTheme: DarkTheme.textTheme, // 🔤 Text Styles (Fixed Reference)
      fontFamily: ThemeManager.getFontFamily(), // 📝 Dynamic Font
      appBarTheme: AppBarTheme(
        backgroundColor: ThemeManager.getPrimaryColor(isDark: true),
        foregroundColor: Colors.white, // 🔵 Default White Text
        elevation: 2,
      ),
    );
  }
}
