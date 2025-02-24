import 'dart:async'; // Added for Timer
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/game_state.dart';
import '../utils/theme_manager.dart';
import 'falling_item_widget.dart';

class GameplayScreen extends StatefulWidget {
  const GameplayScreen({super.key});

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  Timer? _spawnTimer; // Store timers to cancel them
  Timer? _updateTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final gameState = Provider.of<GameState>(context, listen: false);
      gameState.startCountdown(() {
        gameState.startGameTimer(context);
        _startFallingItems(gameState);
      });
    });
  }

  /// 🕒 Start spawning and updating falling items
  void _startFallingItems(GameState gameState) {
    _spawnTimer?.cancel(); // Cancel any existing timer
    _updateTimer?.cancel();

    _spawnTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) gameState.spawnFallingItem();
    });

    _updateTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (mounted) gameState.updateFallingItems();
    });
  }

  @override
  void dispose() {
    _spawnTimer?.cancel(); // Clean up timers
    _updateTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeManager.getThemeData(isDark: false);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ThemeManager.getBackgroundImage()),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          // Wrap Stack in SafeArea for notch/status bar compatibility
          child: Stack(
            children: [
              // 🕒 Game Timer
              Positioned(
                top: 20,
                left: 20,
                child: Consumer<GameState>(
                  builder: (context, gameState, child) {
                    return Text(
                      "Time: ${gameState.timeLeft}",
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        shadows: const [
                          Shadow(
                            color: Colors.black54,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // 🍬 Falling Items
              Consumer<GameState>(
                builder: (context, gameState, child) {
                  return Stack(
                    children: gameState.fallingItems
                        .map((item) => FallingItemWidget(key: ValueKey(item.id), item: item))
                        .toList(),
                  );
                },
              ),

              // 🎮 Pause Button
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: const Icon(Icons.pause, color: Colors.white, size: 32),
                  onPressed: () => _showPauseMenu(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🕹️ Show Pause Menu
  void _showPauseMenu(BuildContext context) {
    final gameState = Provider.of<GameState>(context, listen: false);
    gameState.pauseGame();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Game Paused"),
        content: const Text("Select an option:"),
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
              Navigator.pushNamed(context, '/settings');
            },
            child: const Text("Settings"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context); // Return to main menu
              gameState.resetGame(); // Reset game state
            },
            child: const Text("Exit to Menu"),
          ),
        ],
      ),
    );
  }
}