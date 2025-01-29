import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final int finalScore;

  const GameOverScreen({super.key, required this.finalScore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backgrounds/gameplay_background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Game Over Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Game Over!",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    shadows: [
                      Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 3),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Final Score: $finalScore",
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),

                // Retry Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/gameplay'); // Restart gameplay
                  },
                  child: const Text("Retry"),
                ),
                const SizedBox(height: 20),

                // Main Menu Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/menu'); // Return to main menu
                  },
                  child: const Text("Main Menu"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
