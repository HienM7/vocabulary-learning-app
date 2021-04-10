import 'package:flutter/material.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';

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
        color: Theme.of(context).bottomAppBarColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.maxFinite,
                child: TextButton(
                  onPressed: () => AppRouter.router.navigateTo(
                    context, AppRoutes.login.route),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    overlayColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered))
                          return Colors.blueGrey[800].withOpacity(0.8);
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return Colors.blueGrey[800];
                        return null; // Defer to the widget's default.
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )
                    )
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15.0,
                      bottom: 15.0,
                    ),
                    child: Text('Log In',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.maxFinite,
                child: TextButton(
                  onPressed: () => AppRouter.router.navigateTo(
                    context, AppRoutes.login.route),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    overlayColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered))
                          return Colors.blueGrey[800].withOpacity(0.8);
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return Colors.blueGrey[800];
                        return null; // Defer to the widget's default.
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )
                    )
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15.0,
                      bottom: 15.0,
                    ),
                    child: Text('Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  'Course',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.blueGrey[400],
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  'Contact Us',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Copyright © 2020 | EXPLORE',
                    style: TextStyle(
                      color: Colors.blueGrey[300],
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
