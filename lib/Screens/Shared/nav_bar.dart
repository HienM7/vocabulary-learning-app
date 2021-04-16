import 'package:flutter/material.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBar createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  List _isHovering = [false, false, false];
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
            Text('VOCABLEARN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold
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
                          context, AppRoutes.homePage.route),
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
                          context, AppRoutes.myLists.route),
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
                IconButton(
                  icon: Icon(Icons.account_circle),
                  iconSize: 40,
                  color: Colors.yellow[600],
                  onPressed: (){},
                ),
                SizedBox(width: 23,),
                InkWell(
                  onTap: () {},
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
