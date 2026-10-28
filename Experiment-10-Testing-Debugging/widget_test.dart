import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'widget_test_demo.dart';

void main() {
  testWidgets('Counter starts at zero', (WidgetTester tester) async {
    await tester.pumpWidget(const TestingDemoApp());

    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('Increment button increases counter',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestingDemoApp());

    await tester.tap(find.byKey(const Key('incrementButton')));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Reset button resets counter to zero',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestingDemoApp());

    await tester.tap(find.byKey(const Key('incrementButton')));
    await tester.pump();

    await tester.tap(find.byKey(const Key('resetButton')));
    await tester.pump();

    expect(find.text('0'), findsOneWidget);
  });
}
