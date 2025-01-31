import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/game_state.dart';
import '../components/basket/basket_widget.dart';
import '../components/falling_item_widget.dart';
import '../utils/theme_manager.dart';
import 'game_over_screen.dart'; // Import Game Over Screen

class GameplayScreen extends StatelessWidget {
  const GameplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize GameState
    final gameState = GameState();
    gameState.gameOverCallback = (score) {
      // Navigate to Game Over Screen when time runs out
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GameOverScreen(finalScore: score),
        ),
      );
    };

    return ChangeNotifierProvider.value(
      value: gameState,
      child: Scaffold(
        body: Stack(
          children: [
            // 🌄 **Background Image**
            Positioned.fill(
              child: Image.asset(
                ThemeManager.getBackgroundImage(),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: Colors.black);
                },
              ),
            ),

            // 🎮 **Game UI**
            SafeArea(
              child: Stack(
                children: [
                  // 🏀 **Basket (Player)**
                  Consumer<GameState>(
                    builder: (context, gameState, child) {
                      return BasketWidget(
                        basketLevel: gameState.basketLevel,
                        basketX: gameState.basketX,
                        basketY: gameState.basketY,
                        onMove: gameState.moveBasket,
                        onCatchItem: gameState.handleCollision,
                      );
                    },
                  ),

                  // 🍬 **Falling Items**
                  Consumer<GameState>(
                    builder: (context, gameState, child) {
                      return Stack(
                        children: gameState.fallingItems
                            .map((item) => FallingItemWidget(item: item))
                            .toList(),
                      );
                    },
                  ),

                  // 🕒 **Countdown Timer Display (Before Game Starts & When Resuming)**
                  Consumer<GameState>(
                    builder: (context, gameState, child) {
                      if (gameState.isCountdownActive) {
                        return Center(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 500), // Smooth fade transition
                            opacity: gameState.isCountdownActive ? 1.0 : 0.0,
                            child: Text(
                              gameState.countdownText,
                              style: const TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),

                  // ⏱️ **Game Timer Display (Top Left)**
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Consumer<GameState>(
                      builder: (context, gameState, child) {
                        return Text(
                          "Time: ${gameState.timeLeft}",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),

                  // 🔊 **Pause & Sound Controls**
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Row(
                      children: [
                        // ⏸ **Pause Button**
                        IconButton(
                          icon: const Icon(Icons.pause, color: Colors.white),
                          onPressed: () {
                            Provider.of<GameState>(context, listen: false).pauseGame();
                            _showPauseMenu(context);
                          },
                        ),

                        // 🔊 **Sound Toggle Button**
                        Consumer<GameState>(
                          builder: (context, gameState, child) {
                            return IconButton(
                              icon: Icon(
                                gameState.soundEnabled ? Icons.volume_up : Icons.volume_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                gameState.setSound(!gameState.soundEnabled);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 📌 **Pause Menu Dialog**
  void _showPauseMenu(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Game Paused"),
          content: const Text("Select an option below:"),
          actions: [
            // 🔄 **Resume Game**
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Provider.of<GameState>(context, listen: false).resumeGame();
              },
              child: const Text("Resume"),
            ),


            // ⚙️ **Settings**
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pushNamed(context, "/settings");
              },
              child: const Text("Settings"),
            ),

            // 🚪 **Exit to Main Menu**
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pop(context);
              },
              child: const Text("Exit to Menu"),
            ),
          ],
        );
      },
    );
  }
}



