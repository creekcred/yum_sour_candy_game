import 'dart:math';
import 'package:flutter/material.dart';

class FallingItem {
final String type; // Item type (e.g., "sour_candy", "bitter_candy", "special")
double x; // X position (0.0 to 1.0)
double y; // Y position (0.0 to 1.0)
double dx; // Movement in X direction
double dy; // Movement in Y direction
bool markForRemoval = false; // Flag for removal after collision

FallingItem({
required this.type,
required this.x,
required this.y,
required this.dx,
required this.dy,
});

/// Updates the position of the falling item
void updatePosition() {
x += dx;
y += dy;

// Bounce off walls
if (x <= 0 || x >= 1) {
dx = -dx;
}
}
}