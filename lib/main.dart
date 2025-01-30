import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:yum_sour_candy_game/screens/scoreboard_screen.dart';
import 'state/game_state.dart';
import 'screens/main_menu.dart';
import 'screens/gameplay_screen.dart';
import 'screens/settings_screen.dart';
import 'utils/theme_manager.dart';

void main() {
  initializeApp();
  runApp(const YumSourCandyGame());
}

/// 🛠 **Initialize App**
void initializeApp() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  // Example: Load data or initialize services
  Future.wait([
    // Load game data or settings
    Future.delayed(const Duration(seconds: 1)),
  ]).then((_) {
    FlutterNativeSplash.remove();
  });
}

/// 🎮 **Main App Widget**
class YumSourCandyGame extends StatelessWidget {
  const YumSourCandyGame({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = GameState(); // Initialize GameState
    gameState.initialize(); // Call any initialization method if needed

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => gameState), // Pass the initialized GameState
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Yum Sour Candy Game",
        theme: ThemeManager.getThemeData(isDark: false), // Example
        darkTheme: ThemeManager.getThemeData(isDark: true), // Example
        initialRoute: '/gameplay', // Set GameplayScreen as the initial route
        routes: {
          '/': (context) => const MainMenuScreen(), // Keep this if you still need it
          '/gameplay': (context) => const GameplayScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/scoreboard': (context) => const ScoreboardScreen() 
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/gameplay':
              return MaterialPageRoute(builder: (context) => const GameplayScreen());
            case '/settings':
              return MaterialPageRoute(builder: (context) => const SettingsScreen());
            case '/scoreboard':
              return MaterialPageRoute(builder: (context) => const ScoreboardScreen());
            default:
              return MaterialPageRoute(
                builder: (context) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ),
              );
          }
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              body: Center(
                child: Text('Error: Route not found!'),
              ),
            ),
          );
        },
      ),
    );
  }
}