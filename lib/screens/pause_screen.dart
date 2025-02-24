import 'package:flutter/material.dart';
import 'package:yum_sour_candy_game/screens/main_menu_screen.dart'; // Adjust the import path as necessary

class PauseScreen extends StatelessWidget {
  const PauseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Paused",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Resume the game
              },
              child: const Text("Resume"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainMenuScreen()),
                );
              },
              child: const Text("Main Menu"),
            ),
          ],
        ),
      ),
    );
  }
}