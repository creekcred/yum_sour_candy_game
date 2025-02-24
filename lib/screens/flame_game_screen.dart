import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../game/my_flame_game.dart';  // Import your Flame game class

/// 🎮 **Flame Game Screen** that wraps the Flame `GameWidget`
class FlameGameScreen extends StatelessWidget {
  const FlameGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(game: MyFlameGame()), // Your custom Flame game
    );
  }
}
