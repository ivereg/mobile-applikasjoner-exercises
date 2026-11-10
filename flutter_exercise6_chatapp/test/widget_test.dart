import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_exercise6_chatapp/screens/auth.dart';

// The whole App needs a live Firebase connection, so the login screen is
// tested on its own. Firebase is only touched when the form is submitted.
void main() {
  testWidgets('Login screen shows email and password fields', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: AuthScreen()));

    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets('Switching to signup adds a username field', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: AuthScreen()));

    await tester.tap(find.text('Create an account'));
    await tester.pump();

    expect(find.text('Signup'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
  });
}
