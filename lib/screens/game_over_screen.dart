import 'package:flutter/material.dart';
import '../utils/theme_manager.dart'; // Assuming this exists for theming
import 'package:provider/provider.dart';
import '../state/game_state.dart';

class GameOverScreen extends StatelessWidget {
  final int finalScore;

  const GameOverScreen({super.key, required this.finalScore});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context, listen: false);
    final theme = ThemeManager.getThemeData(isDark: gameState.darkMode);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [theme.primaryColor.withOpacity(0.8), Colors.black.withOpacity(0.5)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Game Over!",
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: const [
                      Shadow(color: Colors.black87, blurRadius: 6, offset: Offset(2, 2)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Score: $finalScore",
                  style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () {
                    gameState.initialize();
                    Navigator.pushReplacementNamed(context, '/gameplay');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: theme.primaryColorDark,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Restart", style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {
                    gameState.initialize();
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: BorderSide(color: theme.primaryColorLight),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Main Menu", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}