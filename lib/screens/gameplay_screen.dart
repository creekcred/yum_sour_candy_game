import 'dart:async'; // ⏰ For timer functionality
import 'package:flutter/material.dart'; // 📱 Flutter widgets
import 'package:provider/provider.dart'; // 🔄 State management with Provider
import '../components/basket/basket_widget.dart'; // 🧺 Custom basket widget
import 'game_over_screen.dart'; // 🚪 Game Over screen

// 🕹️ Game State: Manages timer, score, and game status
class GameState with ChangeNotifier {
  int timeLeft = 60; // ⏳ Game starts with 60 seconds
  int score = 0; // 🏆 Player's score
  bool isPaused = false; // ⏸️ Game is running by default
  late BuildContext context; // 🛠️ Used for navigation

  // ⏳ Start the game timer
  void startTimer(BuildContext ctx) {
    context = ctx; // Store the context for navigation
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isPaused) return; // Skip if the game is paused
      if (timeLeft > 0) {
        timeLeft--; // Decrease time
        notifyListeners(); // Notify UI to update
      } else {
        timer.cancel(); // Stop the timer
        _showGameOver(); // 🚀 Navigate to Game Over screen
      }
    });
  }

  // ⏸️ Pause or resume the game
  void pauseGame() {
    isPaused = !isPaused; // Toggle pause state
    notifyListeners(); // Notify UI to update
  }

  // 🏆 Increase the player's score
  void incrementScore(int points) {
    score += points; // Add points
    notifyListeners(); // Notify UI to update
  }

  // ❌ Decrease the player's score
  void decrementScore(int points) {
    score -= points; // Subtract points
    if (score < 0) score = 0; // Prevent negative score
    notifyListeners(); // Notify UI to update
  }

  // 🚪 Navigate to the Game Over screen when the game ends
  void _showGameOver() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GameOverScreen(finalScore: score), // Pass final score
      ),
    );
  }

  // 🔄 Reset the game to its initial state
  void resetGame() {
    timeLeft = 60; // Reset timer
    score = 0; // Reset score
    isPaused = false; // Resume game
    notifyListeners(); // Notify UI to update
  }
}

// 🎮 Gameplay Screen: Main game logic and visuals
class GameplayScreen extends StatelessWidget {
  const GameplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🛠️ Use Provider to manage game state
    return ChangeNotifierProvider(
      create: (_) => GameState()..startTimer(context), // Start the game timer
      child: Scaffold(
        body: Stack(
          children: [
            // 🌄 Background Image
            Container(
              width: double.infinity, // Full screen width
              height: double.infinity, // Full screen height
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/backgrounds/gameplay_background.png"),
                  fit: BoxFit.cover, // Cover the entire screen
                ),
              ),
            ),

            // ⏳ Timer Display (Top Center)
            Positioned(
              top: 40, // Position from the top
              left: MediaQuery.of(context).size.width / 2 - 80, // Center horizontally
              child: Consumer<GameState>( // Listen to game state changes
                builder: (context, gameState, child) {
                  return Text(
                    "Time Left: ${gameState.timeLeft}s", // Show remaining time
                    style: const TextStyle(
                      fontSize: 24,
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
                  );
                },
              ),
            ),

            // 🔄 Pause & Play Button (Top Right)
            Positioned(
              top: 40,
              right: 20,
              child: Consumer<GameState>(
                builder: (context, gameState, child) {
                  return IconButton(
                    icon: Icon(
                      gameState.isPaused ? Icons.play_arrow : Icons.pause, // Play or pause icon
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      gameState.pauseGame(); // Pause or resume game
                      if (gameState.isPaused) {
                        _showPauseMenu(context, gameState); // Show pause menu
                      }
                    },
                  );
                },
              ),
            ),

            // 🧺 Basket Widget (Bottom Center)
            Positioned(
              bottom: 50, // Position from the bottom
              left: MediaQuery.of(context).size.width / 2 - 50, // Center horizontally
              child: const BasketWidget(basketLevel: 1), // Default Level 1 Basket
            ),

            // 🔢 Score Display (Top Left)
            Positioned(
              top: 40,
              left: 20, // Position from the left
              child: Consumer<GameState>(
                builder: (context, gameState, child) {
                  return Text(
                    "Score: ${gameState.score}", // Show current score
                    style: const TextStyle(
                      fontSize: 24,
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 📋 Pause Menu Dialog: Provides options to resume, restart, or exit
  void _showPauseMenu(BuildContext context, GameState gameState) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (context) {
        return AlertDialog(
          title: const Text("Game Paused"),
          content: const Text("What would you like to do?"),
          actions: [
            // ▶️ Resume Button
            TextButton(
              child: const Text("Resume"),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                gameState.pauseGame(); // Resume the game
              },
            ),
            // 🔄 Restart Button
            TextButton(
              child: const Text("Restart"),
              onPressed: () {
                gameState.resetGame(); // Reset the game state
                Navigator.pop(context); // Close the dialog
              },
            ),
            // 🚪 Exit Button
            TextButton(
              child: const Text("Exit"),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Return to the main menu
              },
            ),
          ],
        );
      },
    );
  }
}


