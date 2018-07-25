import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fate_dice/main.dart' show MyApp;
import 'package:fate_dice/fate_die.dart' show FateDie;

void main() {
  testWidgets('smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(new MyApp());

    // Verify that ther's a 'roll' button
    expect(find.text('Roll'), findsOneWidget);

    // Tap the 'Roll' button and trigger a frame.
    await tester.tap(find.byType(RaisedButton));
    await tester.pumpAndSettle();

    // Verify that there are dice.
    expect(find.byType(FateDie), findsNWidgets(4));
  });
}
