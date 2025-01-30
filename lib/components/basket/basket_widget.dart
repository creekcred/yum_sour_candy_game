import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ✅ Required for keyboard input

class BasketWidget extends StatefulWidget {
  final int basketLevel;
  final double basketX;
  final double basketY;
  final Function(double, double) onMove;
  final Function(String) onCatchItem;

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
  final FocusNode _focusNode = FocusNode(); // ✅ Focus for keyboard inputs

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus(); // ✅ Ensure the widget listens for key events
  }

  @override
  void dispose() {
    _focusNode.dispose(); // ✅ Dispose to prevent memory leaks
    super.dispose();
  }

  /// 🎮 **Handle Keyboard Controls (Arrow Keys)**
  void _handleKey(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      double moveAmount = 0.02; // 🔹 Adjust movement speed

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
        autofocus: true, // ✅ Auto-focus on this widget for keyboard inputs
        onKey: _handleKey, // ✅ Handle arrow key movements
        child: GestureDetector(
          onPanUpdate: (details) {
            double dx = details.delta.dx / MediaQuery.of(context).size.width;
            double dy = details.delta.dy / MediaQuery.of(context).size.height;
            widget.onMove(dx, dy); // ✅ Move based on touch drag
          },
          child: Image.asset(
            "assets/sprites/themes/default/basket/basic_basket.png",
            width: 100,
            height: 100,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error, size: 80, color: Colors.red);
            },
          ),
        ),
      ),
    );
  }
}

