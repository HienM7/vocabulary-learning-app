// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vocabulary_learning_app/Screens/profile/mainProfile.dart';

void main() {
  testWidgets('Profile screen has profile items', (WidgetTester tester) async {    
    // Build the Profile Screen and trigger a frame.
    await tester.pumpWidget(new MainProfile());

    // Verify that our counter starts at 0.
    // expect(find.text('@gmail.com'), findsOneWidget);
    expect(find.text('Invite a friend'), findsOneWidget);
    expect(find.text('Change password'), findsOneWidget);
  });
}
