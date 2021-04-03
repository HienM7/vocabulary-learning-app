import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:vocabulary_learning_app/Screens/profile/profile.dart';
import 'package:vocabulary_learning_app/Screens/testCRUD/home.dart';

import 'package:vocabulary_learning_app/constants/constants.dart';
import 'package:vocabulary_learning_app/Login/login.dart';
import 'package:vocabulary_learning_app/Register/register.dart';
import 'package:vocabulary_learning_app/Screens/vocab_list/vocab_list.dart';
import 'package:vocabulary_learning_app/Home/home.dart';
import 'package:vocabulary_learning_app/Home/home_page.dart';

import 'Home/home.dart';
void main() {
  // SystemChrome.setEnabledSystemUIOverlays([]);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
              '/list': (context) => TablePage(),
              '/todo-test': (context) => Home(),
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
