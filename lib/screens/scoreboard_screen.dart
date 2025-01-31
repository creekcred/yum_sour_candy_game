import 'package:flutter/material.dart';

class ScoreboardScreen extends StatelessWidget {
  const ScoreboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scoreboard'),
      ),
      body: const Center(
        child: Text('Scoreboard content goes here'),
      ),
    );
  }
}