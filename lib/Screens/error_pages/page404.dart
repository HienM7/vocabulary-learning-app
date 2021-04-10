import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';

class RouteNotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Page not found"),
            TextButton(
              onPressed: () => AppRouter.router.navigateTo(
                context,
                AppRoutes.homePage.route,
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
