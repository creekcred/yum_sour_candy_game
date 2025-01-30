import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/game_state.dart';
import 'scoreboard_screen.dart';
import 'main_menu.dart';

class GameOverScreen extends StatelessWidget {
  final int finalScore;

  const GameOverScreen({super.key, required this.finalScore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark theme for dramatic effect
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🏆 **Game Over Title**
            const Text(
              "Game Over",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.red),
            ),

            const SizedBox(height: 20),

            // 🏅 **Final Score Display**
            Text(
              "Final Score: $finalScore",
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),

            const SizedBox(height: 40),

            // 🔄 **Restart Button**
            ElevatedButton(
              onPressed: () {
                Provider.of<GameState>(context, listen: false).restartGame(context);
                Navigator.pushReplacementNamed(context, '/gameplay');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text("Restart", style: TextStyle(fontSize: 24, color: Colors.white)),
            ),

            const SizedBox(height: 20),

            // 📜 **View Scoreboard Button**
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScoreboardScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text("View Scoreboard", style: TextStyle(fontSize: 24, color: Colors.white)),
            ),

            const SizedBox(height: 20),

            // 🚪 **Exit to Menu Button**
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainMenuScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text("Exit to Menu", style: TextStyle(fontSize: 24, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}