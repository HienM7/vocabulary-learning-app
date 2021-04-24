// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocabulary_learning_app/Home/home.dart';

import 'mock.dart';

void main() async {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });
  
  testWidgets('Landing page has Get Started text', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(home: new HomePage())
    );
    await tester.pumpWidget(testWidget);

    // Verify that our counter starts at 0.
    // expect(find.text('@gmail.com'), findsOneWidget);
    expect(find.text('Get started'), findsOneWidget);
  });
}
