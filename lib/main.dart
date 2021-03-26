import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:vocabulary_learning_app/Screens/profile/profile.dart';

import 'package:vocabulary_learning_app/constants/constants.dart';
import 'package:vocabulary_learning_app/Login/login.dart';
// import 'package:vocabulary_learning_app/Screens/login/login.dart';
import 'package:vocabulary_learning_app/Register/register.dart';
import 'package:vocabulary_learning_app/Home/home.dart';
import 'package:vocabulary_learning_app/Home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
              '/home': (context) => HomePage(),
              '/home-page': (context) => HomePageUser(),
            },

            home: LoginPage(),
            // home: MyHomePage(title: 'Flutter Demo Home Page'),
            
          );
        }
      )
    );
  }
}
