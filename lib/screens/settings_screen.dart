import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/game_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool soundEnabled = true;
  bool musicEnabled = true;
  bool vibrationEnabled = true;
  String selectedDifficulty = "Medium";
  bool darkMode = false;
  final Color primaryPink = Color(0xFFE91E63); // 🌸 Define the pink color

  @override
  void initState() {
    super.initState();
    final gameState = Provider.of<GameState>(context, listen: false);
    soundEnabled = gameState.soundEnabled;
    musicEnabled = gameState.musicEnabled;
    vibrationEnabled = gameState.vibrationEnabled;
    selectedDifficulty = gameState.difficulty;
    darkMode = gameState.darkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: primaryPink, // 🎨 Apply pink color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 🎵 Sound Settings
          SwitchListTile(
            title: const Text("Sound Effects"),
            activeColor: primaryPink, // 🎨 Pink toggle color
            value: soundEnabled,
            onChanged: (value) {
              setState(() => soundEnabled = value);
              Provider.of<GameState>(context, listen: false).setSound(value);
            },
          ),
          SwitchListTile(
            title: const Text("Music"),
            activeColor: primaryPink, // 🎨 Pink toggle color
            value: musicEnabled,
            onChanged: (value) {
              setState(() => musicEnabled = value);
              Provider.of<GameState>(context, listen: false).setMusic(value);
            },
          ),

          // 📳 Vibration Setting
          SwitchListTile(
            title: const Text("Vibration"),
            activeColor: primaryPink, // 🎨 Pink toggle color
            value: vibrationEnabled,
            onChanged: (value) {
              setState(() => vibrationEnabled = value);
              Provider.of<GameState>(context, listen: false).setVibration(value);
            },
          ),

          // 🎮 Difficulty Selection
          ListTile(
            title: const Text("Game Difficulty"),
            trailing: DropdownButton<String>(
              value: selectedDifficulty,
              dropdownColor: primaryPink.withOpacity(0.9), // 🎨 Pink dropdown background
              items: ["Easy", "Medium", "Hard"]
                  .map((difficulty) => DropdownMenuItem(
                value: difficulty,
                child: Text(difficulty, style: const TextStyle(color: Colors.white)),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() => selectedDifficulty = value!);
                Provider.of<GameState>(context, listen: false).setDifficulty(value!);
              },
            ),
          ),

          // 🌙 Theme & Appearance
          SwitchListTile(
            title: const Text("Dark Mode"),
            activeColor: primaryPink, // 🎨 Pink toggle color
            value: darkMode,
            onChanged: (value) {
              setState(() => darkMode = value);
              Provider.of<GameState>(context, listen: false).setDarkMode(value);
            },
          ),

          // ⚠️ Reset & Exit
          ListTile(
            title: const Text("Reset Game Progress"),
            leading: const Icon(Icons.restore),
            textColor: primaryPink, // 🎨 Pink text color
            iconColor: primaryPink, // 🎨 Pink icon color
            onTap: () {
              Provider.of<GameState>(context, listen: false).resetProgress();
            },
          ),
        ],
      ),
    );
  }
}
