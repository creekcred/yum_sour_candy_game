import 'package:flutter/material.dart';

class BasketWidget extends StatelessWidget {
  final int basketLevel; // Basket level (1 to 5)

  const BasketWidget({super.key, required this.basketLevel});

  @override
  Widget build(BuildContext context) {
    // Select the correct basket image based on the basket level
    String basketImage = "assets/sprites/basket/basic_basket.png";

    switch (basketLevel) {
      case 2:
        basketImage = "assets/sprites/basket/level_2_basic_basket.png";
        break;
      case 3:
        basketImage = "assets/sprites/basket/level_3_basic_basket.png";
        break;
      case 4:
        basketImage = "assets/sprites/basket/level_4_basic_basket.png";
        break;
      case 5:
        basketImage = "assets/sprites/basket/level_5_basic_basket.png";
        break;
      default:
        basketImage = "assets/sprites/basket/basic_basket.png";
    }

    return Image.asset(
      basketImage,
      width: 100, // Adjust the size of the basket as needed
      height: 80,
      fit: BoxFit.contain,
    );
  }
}
