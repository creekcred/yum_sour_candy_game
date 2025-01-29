import 'package:flutter/material.dart';
import '../state/game_state.dart';

class FallingItemWidget extends StatelessWidget {
  final FallingItem item;

  const FallingItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 50),
      left: item.x * MediaQuery.of(context).size.width,
      top: item.y * MediaQuery.of(context).size.height,
      child: _buildItemVisual(),
    );
  }

  Widget _buildItemVisual() {
    switch (item.type) {
      case 'sour_candy':
        return Image.asset('assets/sour_candy.png', width: 30, height: 30);
      case 'bitter_candy':
        return Image.asset('assets/bitter_candy.png', width: 30, height: 30);
      case 'special':
        return Image.asset('assets/special_candy.png', width: 35, height: 35);
      default:
        return Container(width: 30, height: 30, color: Colors.grey);
    }
  }
}
