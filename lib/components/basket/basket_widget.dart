import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ✅ Required for Keyboard Input
import '../../utils/theme_manager.dart'; // ✅ Loads Basket Images

class BasketWidget extends StatefulWidget {
  final int basketLevel;
  final double basketX;
  final double basketY;
  final Function(double) onMove;
  final Function onCatchItem; // ✅ Added parameter for collision detection

  const BasketWidget({
    super.key,
    required this.basketLevel,
    required this.basketX,
    required this.basketY,
    required this.onMove,
    required this.onCatchItem, // ✅ Now correctly passes collision handler
  });

  @override
  BasketWidgetState createState() => BasketWidgetState();
}

class BasketWidgetState extends State<BasketWidget> {
  late String basketImage;

  @override
  void initState() {
    super.initState();
    _loadBasketImage();
  }

  /// 🎭 **Load Basket Image Based on Level**
  Future<void> _loadBasketImage() async {
    basketImage = await ThemeManager.getAssetPath(
      "themes/default/basket",
      "basket_level_${widget.basketLevel}.png",
    );
    if (mounted) setState(() {});
  }

  /// 🎮 **Keyboard Controls (Arrow Keys)**
  void _handleKey(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      double moveAmount = 0.05;

      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowLeft:
          widget.onMove(-moveAmount);
          break;
        case LogicalKeyboardKey.arrowRight:
          widget.onMove(moveAmount);
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
        focusNode: FocusNode(),
        onKey: _handleKey,
        child: GestureDetector(
          onPanUpdate: (details) {
            double dx = details.delta.dx / MediaQuery.of(context).size.width;
            widget.onMove(dx);
          },
          child: Image.asset(
            basketImage,
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


