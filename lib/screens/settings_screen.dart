import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context), // ✅ Go back to Main Menu
          child: const Text("Back to Menu"),
        ),
      ),
    );
  }
}

