import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'package:vocabulary_learning_app/constants/constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';
import 'constants/router_constants.dart';
import 'package:vocabulary_learning_app/Home/Mylist.dart';
import 'package:vocabulary_learning_app/Screens/profile/editProfile.dart';
import 'package:vocabulary_learning_app/Screens/profile/profile.dart';
import 'package:vocabulary_learning_app/Screens/profile/introduction.dart';

import 'package:vocabulary_learning_app/Screens/testCRUD/home.dart';
import 'package:vocabulary_learning_app/Screens/list_word/list_word.dart';

import 'package:vocabulary_learning_app/constants/constants.dart';
import 'package:vocabulary_learning_app/Login/login.dart';
import 'package:vocabulary_learning_app/Register/register.dart';
import 'package:vocabulary_learning_app/Screens/vocab_list/vocab_list.dart';
import 'package:vocabulary_learning_app/Home/home.dart';
import 'package:vocabulary_learning_app/Home/home_page.dart';
import 'Home/home.dart';

void main(){
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

            onGenerateRoute: AppRouter.router.generator,
            initialRoute: '/',
            routes: {
              '/login': (context) => LoginPage(),
              '/signup': (context) => RegisterPage(),
              '/my-profile': (context) => ProfileScreen(),
              '/list': (context) => TablePage(),
              '/todo-test': (context) => ToDoTestPage(),
              '/home': (context) => HomePage(),
              '/home-page': (context) => HomePageUser(),
              '/my-list': (context) => MyList(),
              '/list-word': (context) => ListWord(),
              '/edit-profile': (context) => EditProfile(),
              '/my-profile/introduction': (context) => Introduction()
            },

            home: LoginPage(),
            // home: MyHomePage(title: 'Flutter Demo Home Page'),
          );
        }));
  }
}
