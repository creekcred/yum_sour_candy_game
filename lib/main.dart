import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/main_menu.dart';
import 'screens/gameplay_screen.dart';
import 'screens/game_over_screen.dart'; // Add Game Over screen

void main() {
  runApp(const MyApp()); // Ensure const for optimized rebuilds
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Added named key parameter for consistency

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes debug banner
      title: 'Yum Sour Candy Game', // App Title
      theme: AppTheme.lightTheme, // Light Theme
      darkTheme: AppTheme.darkTheme, // Dark Theme
      themeMode: ThemeMode.system, // Automatically switch themes
      initialRoute: '/menu', // Define the initial route
      routes: {
        '/menu': (context) => const MainMenu(), // Main Menu
        '/gameplay': (context) => const GameplayScreen(), // Gameplay Screen
        '/gameover': (context) => GameOverScreen(
          finalScore: ModalRoute.of(context)!.settings.arguments as int,
        ), // Game Over Screen
      },
    );
  }
}
