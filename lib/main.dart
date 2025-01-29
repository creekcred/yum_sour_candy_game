import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
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
  Future.delayed(const Duration(seconds: 2), () {
    FlutterNativeSplash.remove();
  });
}

/// 🎮 **Main App Widget**
class YumSourCandyGame extends StatelessWidget {
  const YumSourCandyGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Yum Sour Candy Game",
        theme: ThemeManager.getThemeData(isDark: false),
        darkTheme: ThemeManager.getThemeData(isDark: true),
        initialRoute: '/',
        routes: {
          '/': (context) => const MainMenuScreen(),
          '/gameplay': (context) => const GameplayScreen(),
          '/settings': (context) => const SettingsScreen(),
        },
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
          );
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