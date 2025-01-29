import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key}); // ✅ Use `super.key` for best practice

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/ui/logo.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),

            // Start Game Button
            Custom3DButton(
              text: "Start Game",
              onPressed: () {
                Navigator.pushNamed(context, '/gameplay');
              },
              color1: const Color.fromRGBO(255, 140, 0, 1), // ✅ Fixes `withOpacity`
              color2: const Color.fromRGBO(255, 100, 0, 1),
            ),
            const SizedBox(height: 20),

            // Settings Button
            Custom3DButton(
              text: "Settings",
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              color1: const Color.fromRGBO(34, 139, 34, 1),
              color2: const Color.fromRGBO(0, 100, 0, 1),
            ),
            const SizedBox(height: 20),

            // About Button
            Custom3DButton(
              text: "About",
              onPressed: () {
                Navigator.pushNamed(context, '/about');
              },
              color1: const Color.fromRGBO(30, 144, 255, 1),
              color2: const Color.fromRGBO(0, 0, 139, 1),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom 3D Button Widget
class Custom3DButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color1;
  final Color color2;

  const Custom3DButton({
    super.key, // ✅ Fixes the "super parameter" warning
    required this.text,
    required this.onPressed,
    required this.color1,
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
        backgroundColor: color1, // ✅ Uses solid color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 8, // ✅ Keeps the 3D button effect
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.5), // ✅ Fixes `withOpacity`
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Color.fromRGBO(0, 0, 0, 0.4), // ✅ Uses `Color.fromRGBO()`
              offset: Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
      ),
    );
  }
}


