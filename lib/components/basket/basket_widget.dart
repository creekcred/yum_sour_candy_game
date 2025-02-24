import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ✅ Required for keyboard input

class BasketWidget extends StatefulWidget {
  final int basketLevel;
  final double basketX;
  final double basketY;
  final Function(double, double) onMove;

  const BasketWidget({
    super.key,
    required this.basketLevel,
    required this.basketX,
    required this.basketY,
    required this.onMove,
  });

  @override
  BasketWidgetState createState() => BasketWidgetState();
}

class BasketWidgetState extends State<BasketWidget> {
  final FocusNode _focusNode = FocusNode(); // ✅ Handles keyboard input focus
  double moveSpeed = 0.03; // ✅ Adjust movement speed

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus(); // ✅ Ensures widget listens for key events
  }

  @override
  void dispose() {
    _focusNode.dispose(); // ✅ Prevents memory leaks
    super.dispose();
  }

  /// 🎮 **Handles Keyboard Controls**
  void _handleKey(KeyEvent event) {
    if (event is KeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowLeft:
          widget.onMove(-moveSpeed, 0); // Move Left
          break;
        case LogicalKeyboardKey.arrowRight:
          widget.onMove(moveSpeed, 0); // Move Right
          break;
        case LogicalKeyboardKey.arrowUp:
          widget.onMove(0, -moveSpeed); // Move Up
          break;
        case LogicalKeyboardKey.arrowDown:
          widget.onMove(0, moveSpeed); // Move Down
          break;
      }
    }
  }

  /// 🖐️ **Handles Touch Dragging**
  void _handleDrag(DragUpdateDetails details) {
    double dx = details.delta.dx / MediaQuery.of(context).size.width;
    double dy = details.delta.dy / MediaQuery.of(context).size.height;
    widget.onMove(dx, dy);
  }

  /// 📱 **Handles Swipe Gestures**
  void _handleSwipe(DragEndDetails details) {
    double velocityX = details.velocity.pixelsPerSecond.dx;
    double velocityY = details.velocity.pixelsPerSecond.dy;

    if (velocityX.abs() > velocityY.abs()) {
      // Horizontal Swipe
      widget.onMove(velocityX > 0 ? moveSpeed : -moveSpeed, 0);
    } else {
      // Vertical Swipe
      widget.onMove(0, velocityY > 0 ? moveSpeed : -moveSpeed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * widget.basketX - 50,
      top: MediaQuery.of(context).size.height * widget.basketY - 50,
      child: Focus(
        focusNode: _focusNode,
        autofocus: true, // ✅ Auto-focus for keyboard support
        onKeyEvent: (FocusNode node, KeyEvent event) {
          _handleKey(event);
          return KeyEventResult.handled;
        },
        child: GestureDetector(
          onPanUpdate: _handleDrag, // ✅ Drag movement
          onPanEnd: _handleSwipe, // ✅ Swipe-based movement
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
