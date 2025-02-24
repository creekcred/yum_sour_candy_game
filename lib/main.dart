import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/game_state.dart';
import 'screens/main_menu_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/gameplay_screen.dart';

// Define app-wide constants
const String appTitle = 'Yum Sour Candy Game';

void main() {
  // Ensure Flutter bindings are initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Wrap app in a try-catch for unhandled exceptions
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameState(),
      child: const YumSourCandyGame(),
    ),
  );
}

class YumSourCandyGame extends StatelessWidget {
  const YumSourCandyGame({super.key});

  // Centralized theme data for consistent styling
  ThemeData _buildTheme() {
    return ThemeData(
      primarySwatch: Colors.purple, // A candy-like color
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
        bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pinkAccent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: _buildTheme(), // Apply custom theme
      initialRoute: '/', // Explicitly define initial route
      routes: {
        '/': (context) => const MainMenuScreen(), // Use '/' for home
        '/settings': (context) => const SettingsScreen(),
        '/gameplay': (context) => const GameplayScreen(),
      },
      // Handle unknown routes gracefully
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('404 - Page Not Found')),
          ),
        );
      },
    );
  }
}