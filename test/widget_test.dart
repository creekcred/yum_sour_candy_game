import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yum_sour_candy_game/main.dart'; // Ensure MyApp is defined here
import 'package:yum_sour_candy_game/screens/gameplay_screen.dart'; // Import your gameplay screen

void main() {
  testWidgets('GameplayScreen loads correctly', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the GameplayScreen is loaded.
    expect(find.byType(GameplayScreen), findsOneWidget);

    // Verify that the game timer is displayed.
    expect(find.text('Time: 60'), findsOneWidget);

    // Verify that the basket widget is displayed.
    expect(find.byKey(const Key('basket_widget')), findsOneWidget);

    // Verify that the pause button is displayed.
    expect(find.byIcon(Icons.pause), findsOneWidget);
  });

  testWidgets('Pause button works correctly', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap the pause button.
    await tester.tap(find.byIcon(Icons.pause));
    await tester.pump();

    // Verify that the pause menu is displayed.
    expect(find.text('Game Paused'), findsOneWidget);
    expect(find.text('Resume'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Exit to Menu'), findsOneWidget);
  });
}