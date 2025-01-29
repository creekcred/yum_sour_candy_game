import 'package:flutter/foundation.dart';

/// 📊 **Analytics Service - Tracks Game Events & Player Behavior**
class AnalyticsService {
  /// 🎯 **Log Event**
  static void logEvent(String eventName, {Map<String, dynamic>? parameters}) {
    debugPrint("📊 Analytics Event: $eventName");
    if (parameters != null) {
      debugPrint("🔍 Parameters: $parameters");
    }
  }

  /// 🎮 **Track Game Start**
  static void trackGameStart() {
    logEvent("game_start", parameters: {"timestamp": DateTime.now().toIso8601String()});
  }

  /// 🏆 **Track Score Update**
  static void trackScoreUpdate(int score) {
    logEvent("score_update", parameters: {"score": score});
  }

  /// 🚀 **Track Level Completion**
  static void trackLevelCompletion(int level) {
    logEvent("level_completed", parameters: {"level": level});
  }
}
