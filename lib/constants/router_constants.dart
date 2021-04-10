import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:vocabulary_learning_app/Home/Mylist.dart';
import 'package:vocabulary_learning_app/Home/home.dart';
import 'package:vocabulary_learning_app/Home/home_page.dart';
import 'package:vocabulary_learning_app/Home/home_test_auth.dart';
import 'package:vocabulary_learning_app/Login/login.dart';
import 'package:vocabulary_learning_app/Register/register.dart';
import 'package:vocabulary_learning_app/Screens/course/course.dart';
import 'package:vocabulary_learning_app/Screens/error_pages/page404.dart';
import 'package:vocabulary_learning_app/Screens/list_word/list_word.dart';
import 'package:vocabulary_learning_app/Screens/profile/profile.dart';
import 'package:vocabulary_learning_app/Screens/testCRUD/home.dart';
import 'package:vocabulary_learning_app/Screens/vocab_list/vocab_list.dart';
import 'package:vocabulary_learning_app/UpdatePass/updatepass.dart';

class AppRoutes {
  static final routeNotFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    
    debugPrint("Page not found.");
    return RouteNotFoundPage();
  });

  static final root = AppRoute(
    '/',
    Handler(
      handlerFunc: (context, parameters) => HomePage(),
    ),
  );

  static final home = AppRoute(
    '/home',
    Handler(
      handlerFunc: (context, parameters) => HomePage(),
    ),
  );

  static final homePage = AppRoute(
    '/homepage',
    Handler(
      handlerFunc: (context, parameters) => HomePageUser(),
    ),
  );

  static final login = AppRoute(
    '/login',
    Handler(
      handlerFunc: (context, parameters) => LoginPage(),
    ),
  );

  static final signup = AppRoute(
    '/signup',
    Handler(
      handlerFunc: (context, parameters) => RegisterPage(),
    ),
  );

  static final my = AppRoute(
    '/my',
    Handler(
      handlerFunc: (context, parameters) => ProfileScreen(),
    ),
  );

  static final myProfile = AppRoute(
    '/my/profile',
    Handler(
      handlerFunc: (context, parameters) => ProfileScreen(),
    ),
  );

  static final myLists = AppRoute(
    '/my/lists',
    Handler(
      handlerFunc: (context, parameters) => MyList(),
    ),
  );

  static final myListDetail = AppRoute(
    '/my/lists/:id',
    Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        // ignore: unused_local_variable
        final String listId = params["id"][0];
        return TablePage();
      }
    ),
  );

  static final wordLists = AppRoute(
    '/wordlists',
    Handler(
      handlerFunc: (context, parameters) => ListWord(),  // --> ListsPage
    ),
  );

  static final wordListDetail = AppRoute(
    '/wordlists/:id',
    Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        // ignore: unused_local_variable
        final String listId = params["id"][0];
        return ListWord();  // --> ListDetailPage
      }
    ),
  );

  static final wordListNew = AppRoute(
    '/wordlists/new',
    Handler(
        handlerFunc: (context, parameters) => CoursePage(),
    ),
  );

  static final users = AppRoute(
    '/users',
    Handler(
        handlerFunc: (context, parameters) => HomePage(),  // --> UsersPage
    ),
  );

  static final userDetail = AppRoute(
    '/users/:id',
    Handler(
        handlerFunc: (context, parameters) => HomePage(),  // --> ProfilePage
    ),
  );

  static final practice = AppRoute(
    '/practice',
    // TODO:
    // 3 screens:
    //    1. Game setup: choose a word list to practice
    //    2. Practice with questions
    //    3. Result: List of correct and incorrect answers + total
    Handler(
        handlerFunc: (context, parameters) => HomePage(),  // --> GamePage
    ),
  );

  static final homeAuth = AppRoute(
    '/home-page-auth',
    Handler(
        handlerFunc: (context, parameters) => HomePageAuth(),  // ??
    ),
  );

  static final passwordReset = AppRoute(
    '/resetpass',
    Handler(
        handlerFunc: (context, parameters) => UpdatePassPage(),  // ??
    ),
  );

  // Test route, kept for testing purposes
  static final todoTest = AppRoute(
    '/todotest',
    Handler(
      handlerFunc: (context, parameters) => ToDoTestPage()
    ),
  );

  // Primitive function to get one param detail route (i.e. id)
  static String getDetailRoute(String parentRoute, String id) {
    return "$parentRoute/$id";
  }

  static final List<AppRoute> routes = [
    root,
    home,
    homePage,
    login,
    signup,
    my,
    myProfile,
    myLists,
    myListDetail,
    wordLists,
    wordListDetail,
    wordListNew,
    practice,
    todoTest,
  ];
}
