import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ✅ Required for Keyboard Input
import '../../utils/theme_manager.dart'; // ✅ Loads Basket Images

class BasketWidget extends StatefulWidget {
  final int basketLevel; // 🏆 Basket Level (1-5)
  final double basketX; // 📍 Basket Position (X)
  final double basketY; // 📍 Basket Position (Y)
  final Function(double) onMove; // 🎮 Callback for movement updates

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
  late String basketImage; // 🎭 Stores basket image path
  final FocusNode _focusNode = FocusNode(); // ✅ Required for Keyboard Focus

  @override
  void initState() {
    super.initState();
    _loadBasketImage(); // ✅ Load correct basket image
  }

  @override
  void dispose() {
    _focusNode.dispose(); // ✅ Clean up the focus node
    super.dispose();
  }

  /// 🎭 **Load Basket Image Based on Level**
  Future<void> _loadBasketImage() async {
    basketImage = await ThemeManager.getAssetPath(
      "sprites/themes/default/basket",
      "basket_level_${widget.basketLevel}.png",
    );
    if (mounted) setState(() {}); // ✅ Update UI
  }

  /// 🎮 **Keyboard Controls (Arrow Keys)**
  void _handleKey(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      double moveAmount = 0.05; // ⚡ Speed of movement

      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        widget.onMove(-moveAmount);
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        widget.onMove(moveAmount);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * widget.basketX - 50,
      top: MediaQuery.of(context).size.height * widget.basketY - 50,
      child: RawKeyboardListener(
        focusNode: _focusNode, // ✅ Enables Keyboard Input
        autofocus: true, // ✅ Ensures it gets focus
        onKey: _handleKey,
        child: GestureDetector(
          // 📌 **Touch Controls for Mobile/Tablets**
          onPanUpdate: (details) {
            double dx = details.delta.dx / MediaQuery.of(context).size.width;
            widget.onMove(dx); // ✅ Moves Basket Left/Right
          },
          child: Image.asset(
            basketImage, // ✅ Displays Basket Image
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

