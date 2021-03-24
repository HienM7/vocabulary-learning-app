import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:vocabulary_learning_app/Screens/profile/profile.dart';

import 'package:vocabulary_learning_app/constants/constants.dart';
import 'package:vocabulary_learning_app/Login/login.dart';
// import 'package:vocabulary_learning_app/Screens/login/login.dart';
import 'package:vocabulary_learning_app/Register/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: kLightTheme,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeProvider.of(context),
            debugShowCheckedModeBanner: false,

            initialRoute: '/',
            routes: {
              '/login': (context) => LoginPage(),
              '/signup': (context) => RegisterPage(),
              '/my-profile': (context) => ProfileScreen(),
            },

            home: LoginPage(),
            // home: MyHomePage(title: 'Flutter Demo Home Page'),
            
          );
        }
      )
    );
  }
}
