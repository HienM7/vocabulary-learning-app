import 'package:flutter/material.dart';
import 'package:vocabulary_learning_app/Screens/login/login.dart';
import 'package:vocabulary_learning_app/Screens/profile/mainProfile.dart';
import 'package:vocabulary_learning_app/Screens/register/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
      initialRoute: '/',
      routes: {
      '/login': (context) => LoginPage(),
      '/signup': (context) => RegisterScreen(),
      '/my_profile': (context) => MainProfile(),
      },
<<<<<<< HEAD
      home: LoginScreen(),
=======

      home: LoginPage(),
>>>>>>> Login and register (nhat and luan)
      // home: MyHomePage(title: 'Flutter Demo Home Page'),

    );
  }
}
