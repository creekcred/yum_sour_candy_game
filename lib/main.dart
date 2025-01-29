import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'screens/main_menu.dart'; // ✅ Ensure this exists
import 'screens/gameplay_screen.dart'; // ✅ Ensure this exists
import 'screens/settings_screen.dart'; // ✅ Ensure this exists

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Ensure Flutter is ready
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  Future.delayed(const Duration(seconds: 2), () {
    FlutterNativeSplash.remove(); // ✅ Removes splash after 2 seconds
  });

  runApp(const YumSourCandyGame());
}

class YumSourCandyGame extends StatelessWidget {
  const YumSourCandyGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ✅ Hide Debug Banner
      title: "Yum Sour Candy Game",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // ✅ Ensure we start at Main Menu
      routes: {
        '/': (context) => const MainMenuScreen(),
        '/gameplay': (context) => const GameplayScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
