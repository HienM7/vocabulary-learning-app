import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';
import 'package:vocabulary_learning_app/services/notification.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBar createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  NotifService notifService = new NotifService();
  List _isHovering = [false, false, false];
  bool newNotifs = false;
  DateTime lastCheck = DateTime.now().subtract(Duration(minutes: 5));

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.blueGrey[700],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width*0.1, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => AppRouter.router.navigateTo(
                context, AppRoutes.homePage.route,
                transition: TransitionType.none),
              child: Text('VOCABLEARN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              onHover: (value) {
                setState(() {
                  _isHovering[0] = value;
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.home,
                    size: 25,
                    color: _isHovering[0]
                    ? Colors.yellow
                    : Colors.white,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => AppRouter.router.navigateTo(
                          context, AppRoutes.homePage.route,
                          transition: TransitionType.none),
                        child: Text(
                          'Home',
                          style: TextStyle(
                            color: _isHovering[0]
                                ? Colors.yellow
                                : Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(height: 3),
                      // For showing an underline on hover
                      Visibility(
                        maintainAnimation: true,
                        maintainState: true,
                        maintainSize: true,
                        visible: _isHovering[0],
                        child: Container(
                          height: 3,
                          width: 56,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ]
              ),
            ),
            InkWell(
              onTap: () {},
              onHover: (value) {
                setState(() {
                  _isHovering[1] = value;
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.my_library_books_outlined,
                    size: 25,
                    color: _isHovering[1]
                    ? Colors.yellow
                    : Colors.white,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => AppRouter.router.navigateTo(
                          context, AppRoutes.myLists.route,
                          transition: TransitionType.none),
                        child: Text(
                          'My List',
                          style: TextStyle(
                            color: _isHovering[1]
                                ? Colors.yellow
                                : Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(height: 3),
                      // For showing an underline on hover
                      Visibility(
                        maintainAnimation: true,
                        maintainState: true,
                        maintainSize: true,
                        visible: _isHovering[1],
                        child: Container(
                          height: 3,
                          width: 66,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ],
              )
            ),
            Row(
              children: [
                if (DateTime.now().difference(lastCheck).inMinutes > 3)
                //>>>>>>
                FutureBuilder<bool>(
                  future: notifService.checkAnyUnseen(
                    FirebaseAuth.instance.currentUser.uid
                  ),
                  builder: (BuildContext context,
                      AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasData) {
                      lastCheck = DateTime.now();
                      newNotifs = snapshot.data;
                      
                      return IconButton(
                        icon: Icon(
                          newNotifs
                          ? Icons.notifications_active
                          : Icons.notifications
                        ),
                        iconSize: 32,
                        color: newNotifs ? Colors.yellow[400] : Colors.white,
                        onPressed: () => AppRouter.router.navigateTo(
                          context, AppRoutes.notifications.route,
                          transition: TransitionType.none),
                      );
                    } // end if
                    else {
                      return IconButton(
                        icon: Icon(Icons.notifications),
                        iconSize: 32,
                        color: Colors.white,
                        onPressed: () => AppRouter.router.navigateTo(
                          context, AppRoutes.notifications.route,
                          transition: TransitionType.none),
                      );
                    }
                  },
                )
                else
                //>>>>>>
                IconButton(
                  icon: Icon(
                    newNotifs
                    ? Icons.notifications_active
                    : Icons.notifications
                  ),
                  iconSize: 32,
                  color: newNotifs ? Colors.yellow[400] : Colors.white,
                  onPressed: () => AppRouter.router.navigateTo(
                    context, AppRoutes.notifications.route,
                    transition: TransitionType.none),
                ),

                IconButton(
                  icon: Icon(Icons.account_circle),
                  iconSize: 40,
                  color: Colors.yellow[600],
                  onPressed: () => AppRouter.router.navigateTo(
                    context, AppRoutes.myProfile.route,
                    transition: TransitionType.none),
                ),
                SizedBox(width: 23,),
                InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    AppRouter.router.navigateTo(
                      context, AppRoutes.home.route,
                      transition: TransitionType.none);
                  },
                  onHover: (value) {
                    setState(() {
                      _isHovering[2] = value;
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.logout,
                        size: 23,
                        color: _isHovering[2]
                        ? Colors.yellow
                        : Colors.white,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            ' Log Out',
                            style: TextStyle(
                              color: _isHovering[2]
                                  ? Colors.yellow
                                  : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 3),
                          // For showing an underline on hover
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[2],
                            child: Container(
                              height: 3,
                              width: 66,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
