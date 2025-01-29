import 'package:flutter/material.dart';

/// 🔔 **Notification Service - Displays Game Alerts & Reminders**
class NotificationService {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// 🎉 **Show Level Up Notification**
  static void showLevelUp(BuildContext context, int level) {
    showSnackBar(context, "🎯 Level $level Reached! Keep Going!");
  }

  /// 🏆 **Show High Score Notification**
  static void showHighScore(BuildContext context, int score) {
    showSnackBar(context, "🔥 New High Score: $score!");
  }
}
