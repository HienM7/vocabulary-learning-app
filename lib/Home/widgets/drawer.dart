import 'package:flutter/material.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({
    Key key,
  }) : super(key: key);

  @override
  _DrawerHomeState createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
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
                  leading: Icon(Icons.home,),
                  title: Text('Home', style: TextStyle(fontSize: 16),),
                  hoverColor: Colors.grey[300],
                  enabled: true,
                  onTap: () {
                    AppRouter.router.navigateTo(context, AppRoutes.homePage.route);
                  },
                ),
              ),
              Material(
                color: Colors.grey[200],
                child: ListTile(
                  leading: Icon(Icons.my_library_books_outlined,),
                  title: Text('My List', style: TextStyle(fontSize: 16),),
                  hoverColor: Colors.grey[300],
                  enabled: true,
                  onTap: () {
                    AppRouter.router.navigateTo(context, AppRoutes.myLists.route);
                  },
                ),
              ),
              Material(
                color: Colors.grey[200],
                child: ListTile(
                  leading: Icon(Icons.logout,),
                  title: Text('Log Out', style: TextStyle(fontSize: 16),),
                  hoverColor: Colors.grey[300],
                  enabled: true,
                  onTap: () {
                    AppRouter.router.navigateTo(context, AppRoutes.login.route);
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
