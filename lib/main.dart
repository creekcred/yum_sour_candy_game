import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'screens/main_menu.dart'; // ✅ Ensure this exists
import 'screens/gameplay_screen.dart'; // ✅ Ensure this exists
import 'screens/settings_screen.dart'; // ✅ Ensure this exists
import 'utils/theme_manager.dart'; // 🎨 Import ThemeManager

void main() {
  // 🚀 Initialize Flutter and Splash Screen
  initializeApp();
  runApp(const YumSourCandyGame());
}

/// 🛠 **Initialize App**
void initializeApp() {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Ensure Flutter is ready
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  // 🕒 Remove Splash Screen after 2 seconds
  Future.delayed(const Duration(seconds: 2), () {
    FlutterNativeSplash.remove();
  });
}

/// 🎮 **Main App Widget**
class YumSourCandyGame extends StatelessWidget {
  const YumSourCandyGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ✅ Hide Debug Banner
      title: "Yum Sour Candy Game",
      theme: ThemeManager.getThemeData(isDark: false), // 🎨 Light Theme
      darkTheme: ThemeManager.getThemeData(isDark: true), // 🎨 Dark Theme
      initialRoute: '/', // ✅ Ensure we start at Main Menu
      routes: {
        '/': (context) => const MainMenuScreen(),
        '/gameplay': (context) => const GameplayScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
      onGenerateRoute: (settings) {
        // 🚨 Fallback for unknown routes
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
      },
      onUnknownRoute: (settings) {
        // 🚨 Error Screen for unknown routes
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Error: Route not found!'),
            ),
          ),
        );
      },
    );
  }
}