import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yum_sour_candy_game/screens/game_over_screen.dart'; // Adjust path as needed
import 'dart:math';

class FallingItem {
  final String type;
  double x, y, dx, dy;
  bool markForRemoval = false;

  FallingItem({
    required this.type,
    required this.x,
    required this.y,
    required this.dx,
    required this.dy,
  });

  void fall() {
    x += dx;
    y += dy;
  }
}

class GameState extends ChangeNotifier {
  int _timeLeft = 60;
  bool _isPaused = false;
  bool _isCountdownActive = false;
  String _countdownText = "Ready";
  Timer? _gameTimer;
  Timer? _countdownTimer;
  final List<FallingItem> _fallingItems = [];

  // Settings
  bool _soundEnabled = true;
  bool _musicEnabled = true;
  bool _darkMode = false;

  // Getters
  int get timeLeft => _timeLeft;
  bool get isPaused => _isPaused;
  bool get isCountdownActive => _isCountdownActive;
  String get countdownText => _countdownText;
  List<FallingItem> get fallingItems => List.unmodifiable(_fallingItems); // Prevent external mutation
  bool get soundEnabled => _soundEnabled;
  bool get musicEnabled => _musicEnabled;
  bool get darkMode => _darkMode;

  /// Spawn a new falling item
  void spawnFallingItem() {
    final random = Random();
    final type = random.nextBool() ? "sour_candy" : "bitter_candy";
    final x = random.nextDouble(); // 0.0 to 1.0 (screen width fraction)
    final y = 0.0; // Start at top
    final dx = (random.nextDouble() - 0.5) * 0.02; // Horizontal drift
    final dy = random.nextDouble() * 0.02 + 0.01; // Falling speed

    _fallingItems.add(FallingItem(type: type, x: x, y: y, dx: dx, dy: dy));
    notifyListeners();
  }

  /// Update positions of falling items
  void updateFallingItems() {
    for (final item in _fallingItems) {
      item.fall();
      if (item.y > 1.0) item.markForRemoval = true;
    }
    _fallingItems.removeWhere((item) => item.markForRemoval);
    notifyListeners();
  }

  /// Set sound toggle
  void setSound(bool value) {
    _soundEnabled = value;
    notifyListeners();
  }

  /// Set music toggle
  void setMusic(bool value) {
    _musicEnabled = value;
    notifyListeners();
  }

  /// Set dark mode toggle
  void setDarkMode(bool value) {
    _darkMode = value;
    notifyListeners();
  }

  /// Initialize or reset game state
  void initialize() {
    _timeLeft = 60;
    _isPaused = false;
    _isCountdownActive = false;
    _countdownText = "Ready";
    _fallingItems.clear();
    _gameTimer?.cancel();
    _countdownTimer?.cancel();
    notifyListeners();
  }

  /// Start the pre-game countdown
  void startCountdown(VoidCallback onComplete) {
    _isCountdownActive = true;
    _countdownText = "3";
    notifyListeners();

    _countdownTimer?.cancel(); // Cancel any existing timer
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      switch (_countdownText) {
        case "3":
          _countdownText = "2";
          break;
        case "2":
          _countdownText = "1";
          break;
        case "1":
          _countdownText = "Go!";
          break;
        case "Go!":
          timer.cancel();
          _isCountdownActive = false;
          onComplete();
          break;
      }
      notifyListeners();
    });
  }

  /// Start the main game timer
  void startGameTimer(BuildContext context) {
    _gameTimer?.cancel(); // Prevent multiple timers
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isPaused) return;
      if (_timeLeft > 0) {
        _timeLeft--;
        notifyListeners();
      } else {
        timer.cancel();
        _endGame(context);
      }
    });
  }

  /// Pause the game
  void pauseGame() {
    _isPaused = true;
    notifyListeners();
  }

  /// Resume the game
  void resumeGame(BuildContext context) {
    _isPaused = false;
    startGameTimer(context); // Restart timer
    notifyListeners();
  }

  /// Reset game state (e.g., for exiting to menu)
  void resetGame() {
    initialize();
  }

  /// Clean up resources
  @override
  void dispose() {
    _gameTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  /// End game and navigate to GameOverScreen
  void _endGame(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const GameOverScreen(finalScore: 0), // Add score logic later
      ),
    );
  }
}