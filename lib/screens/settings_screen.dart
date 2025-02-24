import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/game_state.dart';
import '../utils/theme_manager.dart'; // Assuming this exists for theming

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    final theme = ThemeManager.getThemeData(isDark: gameState.darkMode);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        elevation: 0, // Flat design
        backgroundColor: theme.primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.primaryColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Preferences",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColorDark,
                ),
              ),
              const SizedBox(height: 16),
              _buildSwitchTile(
                context: context,
                title: "Sound Effects",
                value: gameState.soundEnabled,
                onChanged: gameState.setSound,
                icon: Icons.volume_up,
              ),
              _buildSwitchTile(
                context: context,
                title: "Background Music",
                value: gameState.musicEnabled,
                onChanged: gameState.setMusic,
                icon: Icons.music_note,
              ),
              _buildSwitchTile(
                context: context,
                title: "Dark Mode",
                value: gameState.darkMode,
                onChanged: gameState.setDarkMode,
                icon: Icons.dark_mode,
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Back to Menu"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build a custom SwitchListTile with an icon
  Widget _buildSwitchTile({
    required BuildContext context,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    final theme = ThemeManager.getThemeData(isDark: Provider.of<GameState>(context, listen: false).darkMode);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: SwitchListTile(
        title: Text(title, style: theme.textTheme.bodyLarge),
        secondary: Icon(icon, color: theme.primaryColor),
        value: value,
        activeColor: theme.primaryColor,
        onChanged: onChanged,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}