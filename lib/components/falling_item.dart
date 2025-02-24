import 'package:flutter/material.dart';

class FallingItem {
  double _x; // Horizontal position (0.0 - 1.0)
  double _y; // Vertical position (0.0 - 1.0)
  final String _imagePath; // Path to the image asset (immutable after creation)
  double _size; // Size of the item
  double _dx; // Horizontal movement speed
  double _dy; // Vertical movement speed
  bool markForRemoval = false; // Mark for removal when off-screen

  FallingItem({
    required double x,
    required double y,
    required String imagePath,
    required double size,
    required double dx,
    required double dy,
  })  : _x = x,
        _y = y,
        _imagePath = imagePath,
        _size = size,
        _dx = dx,
        _dy = dy;

  // Getters
  double get x => _x;
  double get y => _y;
  String get imagePath => _imagePath;
  double get size => _size;
  double get dx => _dx;
  double get dy => _dy;
  Offset get position => Offset(_x, _y);

  // Setters (only for mutable properties)
  set x(double value) {
    _x = value.clamp(0.0, 1.0); // Keep within bounds
  }

  set y(double value) {
    _y = value.clamp(0.0, 1.0); // Keep within bounds
  }

  set size(double value) {
    _size = value.clamp(10.0, 100.0); // Reasonable size range
  }

  set dx(double value) {
    _dx = value.clamp(-0.05, 0.05); // Limit horizontal speed
  }

  set dy(double value) {
    _dy = value.clamp(0.0, 0.1); // Limit vertical speed, prevent upward motion
  }

  /// Update position (Falling effect)
  void fall() {
    _x += _dx;
    _y += _dy;
    // Mark for removal if off-screen (y > 1.0)
    if (_y > 1.0) markForRemoval = true;
  }
}

class FallingItemWidget extends StatelessWidget {
  final FallingItem item;

  const FallingItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context); // Cache for performance

    return Positioned(
      left: (screenSize.width * item.x - item.size / 2).clamp(0, screenSize.width - item.size),
      top: (screenSize.height * item.y - item.size / 2).clamp(0, screenSize.height - item.size),
      child: GestureDetector(
        onTap: () {
          // Placeholder for tap interaction (e.g., collect item)
          item.markForRemoval = true; // Example: remove on tap
        },
        child: Image.asset(
          item.imagePath,
          width: item.size,
          height: item.size,
          fit: BoxFit.contain, // Ensure proper scaling
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.error_outline,
            size: item.size,
            color: Colors.red.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}