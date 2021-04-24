import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';

class HomePageAuth extends StatefulWidget {
  @override
  _HomePageAuthState createState() => _HomePageAuthState();
}

class _HomePageAuthState extends State<HomePageAuth> {
  final auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;
  checkAuth() async {
    auth.authStateChanges().listen((user) {
      // not logged in
      if (user == null) {
        AppRouter.router.navigateTo(context, AppRoutes.login.route,
            transition: TransitionType.none);
      }
      // not verified
      else if (!user.emailVerified) {
        AppRouter.router.navigateTo(context, AppRoutes.emailNotVerified.route,
            transition: TransitionType.none);
      }
    });
  }

  getUser() async {
    User firebaseUser = auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      this.checkAuth();
      this.getUser();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'VocabLearn | Logged In',
      primaryColor: Theme.of(context).primaryColor.value,
    ));

    return Scaffold(
        body: Center(
      child: Container(
        child: !isloggedin
            ? CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  SizedBox(height: 40.0),
                  Container(
                    child: Text(
                      "Hello ${user.displayName} ; you are Logged in as ${user.email}",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: signout,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.orange),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                        textStyle: MaterialStateProperty.all(
                            TextStyle(color: Colors.white)),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.fromLTRB(70, 10, 70, 10))),
                    child: Text('Sign Out',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 40.0),
                  ElevatedButton(
                    onPressed: () => AppRouter.router.navigateTo(
                        context, AppRoutes.passwordChange.route,
                        transition: TransitionType.none),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.orange),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                        textStyle: MaterialStateProperty.all(
                            TextStyle(color: Colors.white)),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.fromLTRB(70, 10, 70, 10))),
                    child: Text('Update Password',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
      ),
    ));
  }

  void signout() {
    auth.signOut();
  }
}
