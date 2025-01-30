import 'package:flutter/material.dart';
import '../state/game_state.dart';

class FallingItemWidget extends StatelessWidget {
  final FallingItem item;

  const FallingItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * item.x - 25,
      top: MediaQuery.of(context).size.height * item.y - 25,
      child: Image.asset(
        _getImagePath(item.type),
        width: 50,
        height: 50,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error, size: 50, color: Colors.red);
        },
      ),
    );
  }

  /// 🖼 **Get Image Path for Candy Type**
  String _getImagePath(String type) {
    switch (type) {
      case "sour_candy":
        return "assets/sprites/themes/default/sour_candy/sour_candy.png";
      case "bitter_candy":
        return "assets/sprites/themes/default/bitter_candy/bitter_candy.png";
      case "special":
        return "assets/sprites/themes/default/special_candy.png";
      default:
        return "assets/sprites/themes/default/sour_candy/sour_candy.png";
    }
  }
}
