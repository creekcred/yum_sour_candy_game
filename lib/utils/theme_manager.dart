import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 📆 Detects Seasonal Themes
import 'package:flutter/services.dart' show rootBundle; // 📂 Asset Check

/// 🎭 **ThemeManager - Handles Dynamic Themes & Asset Paths**
class ThemeManager {
  static final String activeTheme = _detectSeasonalTheme(); // 🎄 Auto-detect active theme

  /// 🏆 **Detect Seasonal Theme Automatically**
  static String _detectSeasonalTheme() {
    DateTime now = DateTime.now();
    String monthDay = DateFormat('MM-dd').format(now);

    if (monthDay.startsWith("12")) {
      return "christmas"; // 🎄 December (Christmas Theme)
    } else if (monthDay.startsWith("10")) {
      return "halloween"; // 🎃 October (Halloween Theme)
    } else if (monthDay.startsWith("04")) {
      return "easter"; // 🐰 April (Easter Theme)
    } else if (monthDay.startsWith("06") || monthDay.startsWith("07")) {
      return "summer"; // 🌞 June & July (Summer Theme)
    }
    return "default"; // 🌎 Default Theme
  }

  /// 🌄 **Get Asset Path with Theme Fallback**
  static Future<String> getAssetPath(String category, String assetName) async {
    String themedPath = "assets/sprites/themes/$activeTheme/$category/$assetName";
    String defaultPath = "assets/sprites/themes/default/$category/$assetName";

    return await _assetExists(themedPath) ? themedPath : defaultPath;
  }

  /// 🌆 **Get Background Image Path**
  static String getBackgroundImage() {
    return "assets/backgrounds/gameplay_background.png"; // ✅ Always use default
  }

  /// ✅ **Check if Asset Exists**
  static Future<bool> _assetExists(String path) async {
    try {
      await rootBundle.load(path);
      return true; // ✅ Asset exists
    } catch (e) {
      return false; // ❌ Asset not found
    }
  }

  /// 🎨 **Get Primary Color (Light/Dark)**
  static Color getPrimaryColor({bool isDark = false}) {
    switch (activeTheme) {
      case "christmas":
        return isDark ? Colors.red[900]! : Colors.red[400]!; // 🎄 Red
      case "halloween":
        return isDark ? Colors.deepOrange[900]! : Colors.deepOrange[400]!; // 🎃 Orange
      case "easter":
        return isDark ? Colors.purple[900]! : Colors.purple[400]!; // 🐰 Purple
      case "summer":
        return isDark ? Colors.blue[900]! : Colors.blue[400]!; // 🌞 Blue
      default:
        return isDark ? Colors.blueGrey[900]! : Colors.blue[400]!; // 🔵 Default
    }
  }

  /// 🔤 **Get Font Family**
  static String getFontFamily() {
    switch (activeTheme) {
      case "christmas":
        return "Merriweather"; // 🎄
      case "halloween":
        return "Creepster"; // 🎃
      case "easter":
        return "Pacifico"; // 🐰
      case "summer":
        return "Lobster"; // 🌞
      default:
        return "Roboto"; // 🌎 Default Font
    }
  }

  /// 🎨 **Get ThemeData Based on Active Theme**
  static ThemeData getThemeData({bool isDark = false}) {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: getPrimaryColor(isDark: isDark),
      fontFamily: getFontFamily(),
      textTheme: TextTheme(
        titleLarge: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontSize: 16, color: isDark ? Colors.white : Colors.black87),
        bodyMedium: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : Colors.black54),
      ),
      scaffoldBackgroundColor: isDark ? Colors.grey[900] : Colors.white,
      appBarTheme: AppBarTheme(
        color: getPrimaryColor(isDark: isDark),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}
