import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';

class ExploreDrawer extends StatefulWidget {
  const ExploreDrawer({
    Key key,
  }) : super(key: key);

  @override
  _ExploreDrawerState createState() => _ExploreDrawerState();
}

class _ExploreDrawerState extends State<ExploreDrawer> {
  //bool _isProcessing = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Material(
                color: Colors.grey[200],
                child: ListTile(
                  leading: Icon(Icons.view_list_rounded),
                  title: Text('Course', style: TextStyle(fontSize: 16),),
                  hoverColor: Colors.grey[300],
                  enabled: true,
                  onTap: () {
                    AppRouter.router.navigateTo(
                      context, AppRoutes.homePage.route,
                      transition: TransitionType.none);
                  },
                ),
              ),
              Material(
                color: Colors.grey[200],
                child: ListTile(
                  leading: Icon(Icons.contacts),
                  title: Text('Contact Us', style: TextStyle(fontSize: 16),),
                  hoverColor: Colors.grey[300],
                  enabled: true,
                  onTap: () {
                    
                  },
                ),
              ),
              Material(
                color: Colors.grey[200],
                child: ListTile(
                  leading: Icon(Icons.app_registration),
                  title: Text('Sign Up', style: TextStyle(fontSize: 16),),
                  hoverColor: Colors.grey[300],
                  enabled: true,
                  onTap: () {
                    AppRouter.router.navigateTo(
                      context, AppRoutes.signup.route,
                      transition: TransitionType.none);
                  },
                ),
              ),
              Material(
                color: Colors.grey[200],
                child: ListTile(
                  leading: Icon(Icons.login_rounded),
                  title: Text('Log In', style: TextStyle(fontSize: 16),),
                  hoverColor: Colors.grey[300],
                  enabled: true,
                  onTap: () {
                    AppRouter.router.navigateTo(
                      context, AppRoutes.login.route,
                      transition: TransitionType.none);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
