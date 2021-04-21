import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
<<<<<<< HEAD

import 'package:vocabulary_learning_app/constants/constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';
import 'constants/router_constants.dart';

void main(){
=======
<<<<<<< HEAD
import 'package:vocabulary_learning_app/Screens/profile/profile.dart';
import 'package:vocabulary_learning_app/Screens/testCRUD/home.dart';

import 'package:vocabulary_learning_app/constants/constants.dart';
import 'package:vocabulary_learning_app/Login/login.dart';
import 'package:vocabulary_learning_app/Register/register.dart';
import 'package:vocabulary_learning_app/Screens/vocab_list/vocab_list.dart';
import 'package:vocabulary_learning_app/Home/home.dart';
import 'package:vocabulary_learning_app/Home/home_page.dart';
import 'package:vocabulary_learning_app/Screens/course/course.dart';
=======

import 'package:vocabulary_learning_app/constants/constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';
import 'constants/router_constants.dart';
>>>>>>> be56b39 (build done features profiles)

void main() {
  // SystemChrome.setEnabledSystemUIOverlays([]);
>>>>>>> 99df823 (commit)
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    
    AppRouter appRouter = AppRouter(
      routes: AppRoutes.routes,
      notFoundHandler: AppRoutes.routeNotFoundHandler,
    );

    appRouter.setupRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        initTheme: kLightTheme,
        child: Builder(builder: (context) {
          return MaterialApp(
            title: 'VocabLearn',
            theme: ThemeProvider.of(context),
            debugShowCheckedModeBanner: false,

<<<<<<< HEAD
<<<<<<< HEAD
            onGenerateRoute: AppRouter.router.generator,
=======
=======
>>>>>>> 99df823 (commit)
            initialRoute: '/',
            routes: {
              '/login': (context) => LoginPage(),
              '/signup': (context) => RegisterPage(),
              '/my-profile': (context) => ProfileScreen(),
              '/list': (context) => TablePage(),
              '/todo-test': (context) => Home(),
              '/home': (context) => HomePage(),
              '/home-page': (context) => HomePageUser(),
<<<<<<< HEAD
=======
              '/my-list': (context) => MyList(),
              '/list-word': (context) => ListWord('DfsZ7qHrewovv309K2WV'),
              '/edit-profile': (context) => EditProfile(),
              '/my-profile/introduction': (context) => Introduction()
>>>>>>> 262a0f9 (commit 2)
            },

            home: LoginPage(),
<<<<<<< HEAD
>>>>>>> d329a0a (commit)
=======
=======
            onGenerateRoute: AppRouter.router.generator,
>>>>>>> be56b39 (build done features profiles)
>>>>>>> 99df823 (commit)
            // home: MyHomePage(title: 'Flutter Demo Home Page'),
          );
        }));
  }
}
