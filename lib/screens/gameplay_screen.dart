import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/game_state.dart'; // ✅ Game Logic
import '../components/basket/basket_widget.dart'; // ✅ Basket
import '../components/falling_item_widget.dart'; // ✅ Falling Items
import '../utils/theme_manager.dart'; // ✅ Theme Handling
import '../components/falling_item.dart'; // ✅ Use common FallingItem reference


class GameplayScreen extends StatelessWidget {
  const GameplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameState()..startGameTimer(), // ✅ Start Game on Load
      child: Scaffold(
        body: Stack(
          children: [
            // 🌄 **Background Image**
            Positioned.fill(
              child: Image.asset(
                ThemeManager.getBackgroundImage() ?? "assets/backgrounds/gameplay_background.png",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: Colors.black); // ✅ Prevents missing asset crash
                },
              ),
            ),

            // 🎮 **Game UI Elements**
            Consumer<GameState>(
              builder: (context, gameState, child) {
                return Stack(
                  children: [
                    // 🎮 **Basket (Player)**
                    BasketWidget(
                      basketLevel: gameState.basketLevel, // ✅ Basket Level
                      basketX: gameState.basketX, // ✅ X Position
                      basketY: gameState.basketY, // ✅ Y Position
                      onMove: gameState.moveBasket, // ✅ Updates Basket Position
                    ),  // ✅ Removed `checkCollision`

                    // 🍬 **Falling Items**
                    Stack(
                      children: gameState.fallingItems.map((fallingItem) {
                        return FallingItemWidget(item: fallingItem); // ✅ Corrects mapping
                      }).toList(),
                    ),

                    // 🏆 **Score Display**
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Score: ${gameState.score}",
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),

                    // ⏳ **Timer Display**
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Time Left: ${gameState.timeLeft}s",
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

