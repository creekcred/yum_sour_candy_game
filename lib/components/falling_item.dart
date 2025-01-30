class FallingItem {
  final String type; // 🍬 Candy Type (e.g., sour_candy, bitter_candy)
  double x; // 📍 Horizontal position (0.0 - 1.0)
  double y; // 📍 Vertical position (0.0 - 1.0)
  double dx; // ➡️ Horizontal movement speed
  double dy; // ⬇️ Falling speed
  bool markForRemoval = false; // ❌ Remove when off-screen

  FallingItem({
    required this.type,
    required this.x,
    required this.y,
    required this.dx,
    required this.dy,
  });

  /// ⏬ **Update Position (Falling Effect)**
  void fall() {
    x += dx;
    y += dy;
  }
}
