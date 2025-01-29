import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ✅ Needed for exiting app

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌄 Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/backgrounds/menu_background.png",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.black); // ✅ Prevents missing asset issue
              },
            ),
          ),

          // 🎮 Main Menu UI
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🏆 Game Logo
                Image.asset(
                  "assets/splash/logo.png",
                  width: 150,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported, size: 80, color: Colors.red);
                  },
                ),
                const SizedBox(height: 40),

                // 🎮 Start Game Button
                _buildMenuButton(context, "Start Game", "/gameplay"),
                const SizedBox(height: 20),

                // ⚙️ Settings Button
                _buildMenuButton(context, "Settings", "/settings"),
                const SizedBox(height: 20),

                // 🚪 Exit Button
                _buildExitButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Reusable Navigation Button
  Widget _buildMenuButton(BuildContext context, String text, String route) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      onPressed: () => Navigator.pushNamed(context, route),
      child: Text(text),
    );
  }

  /// 🔹 Exit Button (Closes App)
  Widget _buildExitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: Colors.redAccent,
      ),
      onPressed: () => SystemNavigator.pop(), // ✅ Closes the application
      child: const Text("Exit", style: TextStyle(color: Colors.white)),
    );
  }
}
