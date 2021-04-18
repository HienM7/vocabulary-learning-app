import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';

class RouteNotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
      label: 'VocabLearn | Page not found',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Page not found"),
            TextButton(
              onPressed: () => AppRouter.router.navigateTo(
                context,
                FirebaseAuth.instance.currentUser != null
                  ? AppRoutes.homePage.route
                  : AppRoutes.home.route,
                replace: true,
                clearStack: true,
                transition: TransitionType.none,
              ),
              child: const Text(
                "Go Home",
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
