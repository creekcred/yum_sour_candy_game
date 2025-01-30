import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreboardScreen extends StatefulWidget {
  const ScoreboardScreen({super.key});

  @override
  _ScoreboardScreenState createState() => _ScoreboardScreenState();
}

class _ScoreboardScreenState extends State<ScoreboardScreen> {
  List<int> highScores = [];

  @override
  void initState() {
    super.initState();
    _loadHighScores();
  }

  /// 🎯 **Load High Scores from SharedPreferences**
  Future<void> _loadHighScores() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final scores = prefs.getStringList('high_scores') ?? [];

      setState(() {
        highScores = scores.map((score) => int.tryParse(score) ?? 0).toList();
        highScores.sort((a, b) => b.compareTo(a)); // Sort in descending order
      });
    } catch (e) {
      debugPrint("Error loading high scores: $e");
    }
  }

  /// 🏆 **Clear High Scores**
  Future<void> _clearHighScores() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('high_scores');
      setState(() {
        highScores.clear();
      });
    } catch (e) {
      debugPrint("Error clearing high scores: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("High Scores"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          // 📜 **High Score List**
          Expanded(
            child: highScores.isEmpty
                ? const Center(
              child: Text(
                "No high scores yet!",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            )
                : ListView.builder(
              itemCount: highScores.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    "Score: ${highScores[index]}",
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                );
              },
            ),
          ),

          // 🗑 **Clear Scores Button**
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: _clearHighScores,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text("Clear High Scores", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
