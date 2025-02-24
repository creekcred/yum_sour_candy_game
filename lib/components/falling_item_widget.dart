import 'package:flutter/material.dart';
import 'falling_item.dart';
import '../utils/theme_manager.dart';

class FallingItemWidget extends StatelessWidget {
  final FallingItem item;

  const FallingItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // Cache MediaQuery size for performance
    final screenSize = MediaQuery.sizeOf(context);
    final leftPosition = screenSize.width * item.x - item.size / 2;
    final topPosition = screenSize.height * item.y - item.size / 2;

    return Positioned(
      left: leftPosition.clamp(0, screenSize.width - item.size), // Prevent overflow
      top: topPosition.clamp(0, screenSize.height - item.size),
      child: FutureBuilder<String>(
        future: ThemeManager.getAssetPath(item.category, item.assetName),
        builder: (context, snapshot) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200), // Smooth transition
            child: _buildContent(snapshot, item.size),
          );
        },
      ),
    );
  }

  /// Build the content based on FutureBuilder state
  Widget _buildContent(AsyncSnapshot<String> snapshot, double size) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return SizedBox(
        key: const ValueKey('loading'),
        width: size,
        height: size,
        child: const CircularProgressIndicator(strokeWidth: 2),
      );
    } else if (snapshot.hasError || !snapshot.hasData) {
      return Icon(
        key: const ValueKey('error'),
        Icons.error_outline,
        size: size,
        color: Colors.red.withOpacity(0.7),
      );
    } else {
      return Image.asset(
        snapshot.data!,
        key: ValueKey(snapshot.data),
        width: size,
        height: size,
        fit: BoxFit.contain, // Ensure proper scaling
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.broken_image,
          size: size,
          color: Colors.grey,
        ),
      );
    }
  }
}