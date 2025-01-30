import 'package:flutter/material.dart';

class Scoreboard extends StatelessWidget {
  final int score;

  const Scoreboard({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      right: 20,
      child: Text(
        "Score: $score",
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}