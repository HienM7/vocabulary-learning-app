import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'package:vocabulary_learning_app/constants/constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';
import 'constants/router_constants.dart';

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

<<<<<<< HEAD
            onGenerateRoute: AppRouter.router.generator,
=======
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
>>>>>>> d329a0a (commit)
            // home: MyHomePage(title: 'Flutter Demo Home Page'),
          );
        }));
  }
}
