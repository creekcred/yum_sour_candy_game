import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final int finalScore; // 🏆 Final score passed from the Gameplay screen

  const GameOverScreen({super.key, required this.finalScore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌄 Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backgrounds/gameover_background.png"), // Add your game over background image here
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🎉 Game Over UI
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🏁 Game Over Title
                const Text(
                  "Game Over!",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(3, 3),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20), // Add spacing

                // 🏆 Display Final Score
                Text(
                  "Your Score: $finalScore",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2, 2),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40), // Add more spacing

                // 🔄 Play Again Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Button color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15), // Button size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Rounded corners
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/gameplay'); // Restart the game
                  },
                  child: const Text(
                    "Play Again",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 20), // Add spacing

                // 🚪 Back to Main Menu Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15), // Button size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Rounded corners
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/menu'); // Return to main menu
                  },
                  child: const Text(
                    "Main Menu",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
