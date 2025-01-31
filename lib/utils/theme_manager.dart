import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show rootBundle;

class ThemeManager {
  static final String activeTheme = _detectSeasonalTheme();

  static String _detectSeasonalTheme() {
    DateTime now = DateTime.now();
    int month = now.month;

    if (month == 12) return "christmas";
    if (month == 10) return "halloween";
    if (month == 4) return "easter";
    if (month == 6 || month == 7) return "summer";
    return "default";
  }

  static Future<String> getAssetPath(String category, String assetName) async {
    String themedPath = "assets/sprites/themes/$activeTheme/$category/$assetName";
    String defaultPath = "assets/sprites/themes/default/$category/$assetName";
    return await _assetExists(themedPath) ? themedPath : defaultPath;
  }

  static String getBackgroundImage() {
    return "assets/backgrounds/gameplay_background.png";
  }

  static Future<bool> _assetExists(String path) async {
    try {
      await rootBundle.load(path);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Color getPrimaryColor({bool isDark = false}) {
    switch (activeTheme) {
      case "christmas":
        return isDark ? Colors.red.shade900 : Colors.red.shade400;
      case "halloween":
        return isDark ? Colors.deepOrange.shade900 : Colors.deepOrange.shade400;
      case "easter":
        return isDark ? Colors.purple.shade900 : Colors.purple.shade400;
      case "summer":
        return isDark ? Colors.blue.shade900 : Colors.blue.shade400;
      default:
        return isDark ? Colors.blueGrey.shade900 : Colors.blue.shade400;
    }
  }

  static String getFontFamily() {
    switch (activeTheme) {
      case "christmas":
        return "Merriweather";
      case "halloween":
        return "Creepster";
      case "easter":
        return "Pacifico";
      case "summer":
        return "Lobster";
      default:
        return "Roboto";
    }
  }

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
      scaffoldBackgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
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
