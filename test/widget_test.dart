import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:yum_sour_candy_game/main.dart'; // Import YumSourCandyGame
import 'package:yum_sour_candy_game/screens/gameplay_screen.dart'; // Import your gameplay screen
import 'package:yum_sour_candy_game/state/game_state.dart'; // Import GameState

void main() {
  testWidgets('GameplayScreen loads correctly', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => GameState(),
        child: const YumSourCandyGame(),
      ),
    );

    // Navigate to GameplayScreen
    await tester.tap(find.text('Start Game')); // Replace with your actual button text
    await tester.pump();

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
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => GameState(),
        child: const YumSourCandyGame(),
      ),
    );

    // Navigate to GameplayScreen
    await tester.tap(find.text('Start Game')); // Replace with your actual button text
    await tester.pump();

    // Tap the pause button.
    await tester.tap(find.byIcon(Icons.pause));
    await tester.pump();

    // Verify that the pause menu is displayed.
    expect(find.text('Game Paused'), findsOneWidget);
    expect(find.text('Resume'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Exit to Menu'), findsOneWidget);
  });
testWidgets('Restart game resets the timer and score', (WidgetTester tester) async {
  // Build the app and trigger a frame.
  await tester.pumpWidget(
    ChangeNotifierProvider(
      create: (_) => GameState(),
      child: const YumSourCandyGame(),
    ),
  );

  // Navigate to GameplayScreen
  await tester.tap(find.text('Start Game')); // Replace with your actual button text
  await tester.pump();

  // Tap the pause button to open the pause menu.
  await tester.tap(find.byIcon(Icons.pause));
  await tester.pump();

  // Tap the restart button.
  await tester.tap(find.text('Restart'));
  await tester.pump();

  // Verify that the timer and score are reset.
  expect(find.text('Time: 60'), findsOneWidget);
  expect(find.text('Score: 0'), findsOneWidget);
});

testWidgets('Exit to menu navigates to the main menu', (WidgetTester tester) async {
  // Build the app and trigger a frame.
  await tester.pumpWidget(
    ChangeNotifierProvider(
      create: (_) => GameState(),
      child: const YumSourCandyGame(),
    ),
  );

  // Navigate to GameplayScreen
  await tester.tap(find.text('Start Game')); // Replace with your actual button text
  await tester.pump();

  // Tap the pause button to open the pause menu.
  await tester.tap(find.byIcon(Icons.pause));
  await tester.pump();

  // Tap the exit to menu button.
  await tester.tap(find.text('Exit to Menu'));
  await tester.pumpAndSettle();

  // Verify that the main menu screen is displayed.
  expect(find.text('Main Menu'), findsOneWidget);
});
}