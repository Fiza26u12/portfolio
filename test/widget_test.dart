// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:portfolio/main.dart';

void main() {
  testWidgets('Portfolio renders core sections', (WidgetTester tester) async {
    await tester.pumpWidget(
      const TickerMode(
        enabled: false,
        child: PortfolioApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('FIZA SHEIKH'), findsOneWidget);
    expect(find.text('Featured Projects'), findsOneWidget);
    expect(find.text("Let's Build Something"), findsOneWidget);
  });
}
