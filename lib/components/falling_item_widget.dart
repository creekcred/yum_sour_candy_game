import 'package:flutter/material.dart';
import '../components/falling_item.dart';

/// 🍬 **Falling Item Widget** - Visually represents falling candies
class FallingItemWidget extends StatelessWidget {
  final FallingItem item; // 🎯 Falling Item Object

  const FallingItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 50), // ⏳ Smooth Falling Animation
      left: MediaQuery.of(context).size.width * item.x - 25, // 📍 Adjust X position
      top: MediaQuery.of(context).size.height * item.y, // 📍 Adjust Y position
      child: Image.asset(
        item.imagePath, // 🎨 Display Candy Image
        width: 50,
        height: 50,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error, size: 40, color: Colors.red);
        },
      ),
    );
  }
}
