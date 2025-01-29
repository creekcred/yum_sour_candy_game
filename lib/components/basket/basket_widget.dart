import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ✅ Required for Keyboard Input
import '../../utils/theme_manager.dart'; // ✅ Loads Basket Images

class BasketWidget extends StatefulWidget {
  final int basketLevel;
  final double basketX;
  final double basketY;
  final Function(double, double) onMove; // ✅ Updated to support X and Y movement
  final Function(String) onCatchItem; // ✅ Handles collisions with items (e.g., candies, power-ups)

  const BasketWidget({
    super.key,
    required this.basketLevel,
    required this.basketX,
    required this.basketY,
    required this.onMove,
    required this.onCatchItem,
  });

  @override
  BasketWidgetState createState() => BasketWidgetState();
}

class BasketWidgetState extends State<BasketWidget> {
  late String basketImage;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _loadBasketImage();
    _focusNode.requestFocus(); // ✅ Request focus for keyboard input
  }

  @override
  void didUpdateWidget(BasketWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.basketLevel != widget.basketLevel) {
      _loadBasketImage(); // Reload image if basket level changes
    }
  }

  @override
  void dispose() {
    _focusNode.dispose(); // ✅ Dispose the FocusNode
    super.dispose();
  }

  /// 🎭 **Load Basket Image Based on Level**
  Future<void> _loadBasketImage() async {
    try {
      basketImage = await ThemeManager.getAssetPath(
        "basket",
        "level_${widget.basketLevel}_basic_basket.png", // Updated path
      );
      if (mounted) setState(() {});
    } catch (e) {
      debugPrint("Error loading basket image: $e");
      if (mounted) setState(() {
        basketImage = "assets/placeholder.png"; // Fallback to a placeholder image
      });
    }
  }

  /// 🎮 **Keyboard Controls (Arrow Keys)**
  void _handleKey(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      double moveAmount = 0.02; // Adjust movement speed as needed

      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowLeft:
          widget.onMove(-moveAmount, 0); // Move left
          break;
        case LogicalKeyboardKey.arrowRight:
          widget.onMove(moveAmount, 0); // Move right
          break;
        case LogicalKeyboardKey.arrowUp:
          widget.onMove(0, -moveAmount); // Move up
          break;
        case LogicalKeyboardKey.arrowDown:
          widget.onMove(0, moveAmount); // Move down
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * widget.basketX - 50,
      top: MediaQuery.of(context).size.height * widget.basketY - 50,
      child: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: _handleKey,
        child: GestureDetector(
          onPanUpdate: (details) {
            double dx = details.delta.dx / MediaQuery.of(context).size.width;
            double dy = details.delta.dy / MediaQuery.of(context).size.height;
            widget.onMove(dx, dy); // Move based on touch drag
          },
          child: basketImage.isNotEmpty
              ? Image.asset(
            basketImage,
            width: 100,
            height: 100,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error, size: 80, color: Colors.red);
            },
          )
              : const Icon(Icons.error, size: 80, color: Colors.red), // Fallback for missing image
        ),
      ),
    );
  }
}
