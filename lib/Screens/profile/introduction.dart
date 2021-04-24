// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vocabulary_learning_app/Home/widgets/drawer.dart';
import 'package:vocabulary_learning_app/Screens/Shared/footer.dart';
import 'package:vocabulary_learning_app/Screens/Shared/nav_bar.dart';
import 'package:vocabulary_learning_app/constants/constants.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';
import 'package:vocabulary_learning_app/services/database.dart';

class Introduction extends StatefulWidget {
  @override
  _IntroductionPage createState() => _IntroductionPage();
}

class _IntroductionPage extends State<Introduction> {
  String code;
  String dialCode;
  String name;
  String password;
  String userName;
  String id;
  bool isloop = false;
  String introduction;
  static String userId = FirebaseAuth.instance.currentUser.uid;
  static String email = FirebaseAuth.instance.currentUser.email;
  static String displayName = FirebaseAuth.instance.currentUser.displayName;
  bool isCheck = false;

  CollectionReference firebaseinstance =
      FirebaseFirestore.instance.collection('profiles');

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    var profileInfo = FutureBuilder<QuerySnapshot>(
        future: firebaseinstance.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting &&
              isloop == false) {
            return Text("loading");
          }
          isloop = true;
          for (var document in snapshot.data.docs) {
            // print(document['user_id'] == '/users/$userId');
            if (document['user_id'] == '/users/$userId') {
              introduction = document['introduction'];
              id = document.id;
              code = document['code'];
              dialCode = document['dialCode'];
              name = document['name'];
              displayName = document['display_name'];
            }
          }

          return Expanded(
            child: Column(children: [
              Container(
                height: 120,
                width: 120,
                margin: EdgeInsets.only(top: 50),
                child: Stack(children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        LineAwesomeIcons.pen,
                        color: kDarkPrimaryColor,
                        size: ScreenUtil().setSp(kSpacingUnit.w * 0.2),
                      ),
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                displayName,
                style: kTitleTextStyle,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                email,
              ),
              SizedBox(
                height: 7,
              ),
            ]),
          );
        });

    var themeSwitcher = ThemeSwitcher(builder: (context) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
            onTap: () => AppRouter.router.navigateTo(
                context, AppRoutes.myLists.route,
                transition: TransitionType.none),
            child: AnimatedCrossFade(
                duration: Duration(milliseconds: 200),
                crossFadeState:
                    ThemeProvider.of(context).brightness == Brightness.dark
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                firstChild: GestureDetector(
                  onTap: () =>
                      ThemeSwitcher.of(context).changeTheme(theme: kLightTheme),
                  child: Icon(
                    LineAwesomeIcons.sun,
                    size: 40,
                  ),
                ),
                secondChild: GestureDetector(
                  onTap: () =>
                      ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme),
                  child: Icon(
                    LineAwesomeIcons.moon,
                    size: 40,
                  ),
                ))),
      );
    });
    var header = Container(
        margin: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 5)
            .copyWith(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => AppRouter.router.navigateTo(
                    context, AppRoutes.myProfile.route,
                    transition: TransitionType.none),
                child: Icon(
                  LineAwesomeIcons.arrow_left,
                  size: 40,
                ),
              ),
            ),
            profileInfo,
            themeSwitcher,
          ],
        ));

    return ThemeSwitchingArea(child: Builder(
      builder: (context) {
        var screenSize = MediaQuery.of(context).size;
        return Scaffold(
            appBar: screenSize.width > 800
                ? PreferredSize(
                    preferredSize: Size(screenSize.width, 1000),
                    child: NavBar(),
                  )
                : AppBar(
                    backgroundColor: Colors.blueGrey[700],
                    elevation: 0,
                    centerTitle: true,
                    title: Text(
                      ' VOCABLEARN',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.account_circle),
                        iconSize: 36,
                        color: Colors.yellow[600],
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {},
                      ),
                    ],
                    iconTheme: IconThemeData(color: Colors.white),
                  ),
            drawer: DrawerHome(),
            body: Column(
              children: <Widget>[
                SizedBox(height: 15),
                header,
                FutureBuilder<QuerySnapshot>(
                    future: firebaseinstance.get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting &&
                          isloop == false) {
                        return Text("loading");
                      }
                      isloop = true;
                      for (var document in snapshot.data.docs) {
                       // print(document['user_id'] == '/users/$userId');
                        if (document['user_id'] == '/users/$userId') {
                          introduction = document['introduction'];
                          id = document.id;
                          code = document['code'];
                          dialCode = document['dialCode'];
                          name = document['name'];
                          displayName = document['display_name'];
                        }
                      }
                      return Expanded(
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: CountryCodePicker(
                                onChanged: print,
                                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                initialSelection: code,
                                favorite: [dialCode, code],
                                // optional. Shows only country name and flag
                                showCountryOnly: true,
                                // optional. Shows only country name and flag when popup is closed.
                                showOnlyCountryWhenClosed: false,
                                enabled: false,
                                // optional. aligns the fla g and the Text left
                                alignLeft: false,
                              ),
                            ),
                            IntroductionItem(
                              text: introduction,
                            ),
                            Footer()
                          ],
                        ),
                      );
                    }),
              ],
            ));
      },
    ));
  }
}

class IntroductionItem extends StatelessWidget {
  final String text;

  const IntroductionItem({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 5)
          .copyWith(bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).backgroundColor),
      child: Row(
        children: <Widget>[
          SizedBox(width: 25),
          Text(this.text,
              style: kTitleTextStyle.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 17)),
        ],
      ),
    );
  }
}
