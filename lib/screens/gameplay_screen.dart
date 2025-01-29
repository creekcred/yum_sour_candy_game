import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/game_state.dart';
import '../components/basket/basket_widget.dart';
import '../components/falling_item_widget.dart';
import '../utils/theme_manager.dart';

class GameplayScreen extends StatelessWidget {
  const GameplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameState()..startCountdown(() {
        Provider.of<GameState>(context, listen: false).startGameTimer();
      }),
      child: Scaffold(
        body: Stack(
          children: [
            // 🌄 **Background Image**
            Positioned.fill(
              child: Image.asset(
                ThemeManager.getBackgroundImage() ?? "assets/backgrounds/gameplay_background.png",
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
                  // 🎮 **Basket (Player)**
                  Consumer<GameState>(
                    builder: (context, gameState, child) {
                      return BasketWidget(
                        basketLevel: gameState.basketLevel,
                        basketX: gameState.basketX,
                        basketY: gameState.basketY,
                        onMove: gameState.moveBasket,
                        onCatchItem: gameState.handleCollision, // ✅ Updated to match basket_widget.dart
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

                  // 🕒 **Countdown Timer Display**
                  Consumer<GameState>(
                    builder: (context, gameState, child) {
                      if (gameState.isCountdownActive) {
                        return Center(
                          child: Text(
                            gameState.countdownText,
                            style: const TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),

                  // ⬅️ **Pause Button (Top-Left FAB)**
                  Positioned(
                    top: 30,
                    left: 20,
                    child: FloatingActionButton(
                      onPressed: () {
                        Provider.of<GameState>(context, listen: false).pauseGame();
                      },
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: Icon(Icons.pause, color: Colors.white),
                    ),
                  ),

                  // 🍔 **Hamburger Menu (Top-Right FAB)**
                  Positioned(
                    top: 30,
                    right: 20,
                    child: FloatingActionButton(
                      onPressed: () {
                        _showPauseMenu(context);
                      },
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: Icon(Icons.menu, color: Colors.white),
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
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Provider.of<GameState>(context, listen: false).resumeGame();
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


