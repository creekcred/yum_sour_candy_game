import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/game_state.dart';
import '../components/basket/basket_widget.dart';
import '../components/falling_item_widget.dart';
import '../utils/theme_manager.dart';
import 'game_over_screen.dart';

class GameplayScreen extends StatefulWidget {
  const GameplayScreen({super.key});

  @override
  _GameplayScreenState createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final gameState = Provider.of<GameState>(context, listen: false);
      gameState.gameOverCallback = (score) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GameOverScreen(finalScore: score),
          ),
        );
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ThemeManager.getBackgroundImage(),
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Stack(
              children: [
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
                Consumer<GameState>(
                  builder: (context, gameState, child) {
                    return Stack(
                      children: gameState.fallingItems
                          .map((item) => FallingItemWidget(item: item))
                          .toList(),
                    );
                  },
                ),
                Consumer<GameState>(
                  builder: (context, gameState, child) {
                    if (gameState.isCountdownActive) {
                      return Center(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
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
                Positioned(
                  top: 10,
                  right: 10,
                  child: Row(
                    children: [
                      Consumer<GameState>(
                        builder: (context, gameState, child) {
                          return IconButton(
                            icon: const Icon(Icons.pause, color: Colors.white),
                            onPressed: () {
                              _showPauseMenu(context, gameState);
                            },
                          );
                        },
                      ),
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
    );
  }

  void _showPauseMenu(BuildContext context, GameState gameState) {
    gameState.pauseGame();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Game Paused"),
          content: const Text("Select an option below:"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                gameState.resumeGame(context);
              },
              child: const Text("Resume"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pushNamed(context, "/settings");
              },
              child: const Text("Settings"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: const Text("Exit to Menu"),
            ),
          ],
        );
      },
    );
  }
}
