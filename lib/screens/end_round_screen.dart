import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/game_state.dart';
import 'gameplay_screen.dart';
import '../utils/theme_manager.dart'; // Assuming this exists for theming

class EndRoundScreen extends StatelessWidget {
  const EndRoundScreen({super.key});

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
            colors: [theme.primaryColor, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Round Over!",
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: const [
                    Shadow(color: Colors.black54, blurRadius: 4, offset: Offset(2, 2)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Time Left: ${gameState.timeLeft}", // Placeholder; replace with score if applicable
                style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  gameState.initialize();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const GameplayScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: theme.primaryColorDark,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Play Again", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}