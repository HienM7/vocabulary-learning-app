// ignore: avoid_web_libraries_in_flutter
import 'dart:async';
import 'dart:html';

<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
=======
<<<<<<< HEAD
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
<<<<<<< HEAD
>>>>>>> 262a0f9 (commit 2)
<<<<<<< HEAD
>>>>>>> d329a0a (commit)
=======
=======
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
>>>>>>> be56b39 (build done features profiles)
>>>>>>> 99df823 (commit)
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vocabulary_learning_app/Home/widgets/drawer.dart';
import 'package:vocabulary_learning_app/Screens/Shared/footer.dart';
import 'package:vocabulary_learning_app/Screens/Shared/nav_bar.dart';
import 'package:vocabulary_learning_app/constants/constants.dart';
<<<<<<< HEAD
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileScreen> {
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
=======
<<<<<<< HEAD
>>>>>>> 99df823 (commit)

  static String userId = FirebaseAuth.instance.currentUser.uid;
  static String email = FirebaseAuth.instance.currentUser.email;
  static String displayName = FirebaseAuth.instance.currentUser.displayName;
  String code;
  String dialCode;
  String name;
  String id;
  bool isloop = false;
  bool isCheck = false;

  CollectionReference firebaseinstance =
      FirebaseFirestore.instance.collection('profiles');

  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      this.checkAuth();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'VocabLearn | Profile',
      primaryColor: Theme.of(context).primaryColor.value,
    ));

=======
<<<<<<< HEAD
>>>>>>> d329a0a (commit)
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
              displayName = document['display_name'];
              isCheck = true;
              break;
            }
          }
          if (isCheck == false) {
            firebaseinstance.add({
              "code": "VN",
              "dialCode": "+84",
              "display_name": displayName,
              "email": email,
              "first language": "Indian",
              "introduction": "Hi, my name is $displayName. My email is $email.",
              "name": "Việt Nam",
              "user_id": "/users/$userId"
            });
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
<<<<<<< HEAD
              SizedBox(
                height: 10,
              ),
              Text(
                displayName, // --> user.name
                style: kTitleTextStyle,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                email, // --> user.email
                style: kCaptionTextStyle,
              ),
              SizedBox(
                height: 7,
              ),
            ]),
          );
        });
=======
            )
          ]),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Viet Huynh',
          style: kTitleTextStyle,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'huynhvanviet317@gmail.com',
          style: kCaptionTextStyle,
        ),
        SizedBox(
          height: 7,
        ),
      ]),
    );
=======
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'VocabLearn | Profile',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
=======
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileScreen> {
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

  static String userId = FirebaseAuth.instance.currentUser.uid;
  static String email = FirebaseAuth.instance.currentUser.email;
  static String displayName = FirebaseAuth.instance.currentUser.displayName;
  String code;
  String dialCode;
  String name;
  String id;
  bool isloop = false;
  bool isCheck = false;
>>>>>>> be56b39 (build done features profiles)

  CollectionReference firebaseinstance =
      FirebaseFirestore.instance.collection('profiles');

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('users')
      .doc('BXdTNFyd2gajVD4JI4N5EKrVPLA3');

  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      this.checkAuth();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'VocabLearn | Profile',
      primaryColor: Theme.of(context).primaryColor.value,
    ));

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
              displayName = document['display_name'];
              isCheck = true;
              break;
            }
          }
          if (isCheck == false) {
            firebaseinstance.add({
              "code": "VN",
              "dialCode": "+84",
              "display_name": displayName,
              "email": email,
              "first language": "Indian",
              "introduction": "Hi, my name is $displayName. My email is $email.",
              "name": "Việt Nam",
              "user_id": "/users/$userId"
            });
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
<<<<<<< HEAD
                )
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              snapshot.data.docs[0].data()['display_name'],
              style: kTitleTextStyle,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              snapshot.data.docs[0].data()['email'],
              style: kCaptionTextStyle,
            ),
            SizedBox(
              height: 7,
            ),
          ]),
        );
      },
    ));
>>>>>>> 262a0f9 (commit 2)
<<<<<<< HEAD
>>>>>>> d329a0a (commit)
=======
=======
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
                displayName, // --> user.name
                style: kTitleTextStyle,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                email, // --> user.email
                style: kCaptionTextStyle,
              ),
              SizedBox(
                height: 7,
              ),
            ]),
          );
        });
>>>>>>> be56b39 (build done features profiles)
>>>>>>> 99df823 (commit)

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
<<<<<<< HEAD
=======
<<<<<<< HEAD
      margin: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 5)
          .copyWith(bottom: 20),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(
          LineAwesomeIcons.arrow_left,
          size: 40,
        ),
        profileInfo,
        themeSwitcher,
      ],
    )
    );
    
=======
>>>>>>> d329a0a (commit)
        margin: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 5)
            .copyWith(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
<<<<<<< HEAD
<<<<<<< HEAD
                onTap: () => AppRouter.router.navigateTo(
                    context, AppRoutes.homePage.route,
                    transition: TransitionType.none),
=======
                onTap: () {
                  Navigator.pushNamed(context, '/home-page');
                },
>>>>>>> d329a0a (commit)
=======
                onTap: () => AppRouter.router.navigateTo(
                    context, AppRoutes.homePage.route,
                    transition: TransitionType.none),
>>>>>>> 99df823 (commit)
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

<<<<<<< HEAD
=======
>>>>>>> 262a0f9 (commit 2)
>>>>>>> d329a0a (commit)
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
<<<<<<< HEAD
<<<<<<< HEAD
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
                      code = document['code'];
                      dialCode = document['dialCode'];
                      id = document.id;
                    }
                  }
                  return Expanded(
                    child: ListView(
                      children: <Widget>[
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: CountryCodePicker(
                              onChanged: (CountryCode countryCode) {
                                firebaseinstance.doc(id).update({
                                  "code": countryCode.code,
                                  "dialCode": countryCode.dialCode,
                                  "name": countryCode.name
                                });
                              },
                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: code,
                              favorite: [code, dialCode],
                              // optional. Shows only country name and flag
                              showCountryOnly: true,
                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: true,
                              enabled: false,
                              // optional. aligns the fla g and the Text left
                              alignLeft: false,
                            ),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => AppRouter.router.navigateTo(
                                context, AppRoutes.myLists.route,
                                transition: TransitionType.none),
                            child: ProfileListItem(
                              icon: LineAwesomeIcons.history,
                              text: 'Your Word Lists',
                            ),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => AppRouter.router.navigateTo(
                                context, AppRoutes.myLists.route,
                                transition: TransitionType.none),
                            child: ProfileListItem(
                              icon: LineAwesomeIcons.user_plus,
                              text: 'Invite a friend to join us',
                            ),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => AppRouter.router.navigateTo(
                                context, AppRoutes.updateProfile.route,
                                transition: TransitionType.none),
                            child: ProfileListItem(
                              icon: LineAwesomeIcons.alternate_pencil,
                              text: 'Update Profile',
                            ),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => AppRouter.router.navigateTo(
                                context, AppRoutes.introduction.route,
                                transition: TransitionType.none),
                            child: ProfileListItem(
                              icon: LineAwesomeIcons.info,
                              text: 'Introduction',
                            ),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => AppRouter.router.navigateTo(
                                context, AppRoutes.passwordChange.route,
                                transition: TransitionType.none),
                            child: ProfileListItem(
                              icon: LineAwesomeIcons.key,
                              text: 'Change password',
                            ),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => AppRouter.router.navigateTo(
                                context, AppRoutes.myLists.route,
                                transition: TransitionType.none),
                            child: ProfileListItem(
                              icon: LineAwesomeIcons.question_circle,
                              text: 'Help & Support',
                            ),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => AppRouter.router.navigateTo(
                                context, AppRoutes.myLists.route,
                                transition: TransitionType.none),
                            child: ProfileListItem(
                              icon: LineAwesomeIcons.user_shield,
                              text: 'Privacy policy',
                            ),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => AppRouter.router.navigateTo(
                                context, AppRoutes.login.route,
                                transition: TransitionType.none),
                            child: ProfileListItem(
                              icon: LineAwesomeIcons.alternate_sign_out,
                              text: 'Log Out',
                              hasNavigation: false,
                            ),
                          ),
                        ),
                  Footer()
                      ],
                    ),
                  );
                })
=======
=======
>>>>>>> 99df823 (commit)
<<<<<<< HEAD
            Expanded(
              child: ListView(
                children: <Widget>[
                  
                  ProfileListItem(
                    icon: LineAwesomeIcons.history,
                    text: 'Words learned',
                  ),

                  ProfileListItem(
                    icon: LineAwesomeIcons.user_plus,
                    text: 'Invite a friend',
                  ),

                  ProfileListItem(
                  icon: LineAwesomeIcons.key,
                  text: 'Change password',
                  ),

                  ProfileListItem(
                    icon: LineAwesomeIcons.question_circle,
                    text: 'Help & Support',
                  ),
                
                  ProfileListItem(
                    icon: LineAwesomeIcons.user_shield,
                    text: 'Privacy policy',
                  ),
                  ProfileListItem(
                    icon: LineAwesomeIcons.alternate_sign_out,
                    text: 'Logout',
                    hasNavigation: false,
                  ),
                ],
              ),
            ),
=======

            Expanded(
              child: FutureBuilder<QuerySnapshot>(
          future: firebaseInstance.where('user_id', isEqualTo: docRef).get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting &&
            isLoop == false) {
          return Text("Loading...");
        }
        isLoop = true;
     
        return ListView(
                children: <Widget>[
                  Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: CountryCodePicker(
                            onChanged: print,
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: snapshot.data.docs[0].data()['VN'],
                            favorite: [
                              snapshot.data.docs[0].data()['+84'],
                              snapshot.data.docs[0].data()['VN']
                            ],
                            // optional. Shows only country name and flag
                            showCountryOnly: true,
                            // optional. Shows only country name and flag when popup is closed.
                            showOnlyCountryWhenClosed: false,
                            enabled: false,
                            // optional. aligns the fla g and the Text left
                            alignLeft: false,
=======
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
                      code = document['code'];
                      dialCode = document['dialCode'];
                      id = document.id;
                    }
                  }
                  return Expanded(
                    child: ListView(
                      children: <Widget>[
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: CountryCodePicker(
                              onChanged: (CountryCode countryCode) {
                                firebaseinstance.doc(id).update({
                                  "code": countryCode.code,
                                  "dialCode": countryCode.dialCode,
                                  "name": countryCode.name
                                });
                              },
                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: code,
                              favorite: [code, dialCode],
                              // optional. Shows only country name and flag
                              showCountryOnly: true,
                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: true,
                              enabled: true,
                              // optional. aligns the fla g and the Text left
                              alignLeft: false,
                            ),
>>>>>>> be56b39 (build done features profiles)
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => AppRouter.router.navigateTo(
                                context, AppRoutes.myLists.route,
                                transition: TransitionType.none),
                            child: ProfileListItem(
                              icon: LineAwesomeIcons.history,
                              text: 'Your Word Lists',
                            ),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => AppRouter.router.navigateTo(
                                context, AppRoutes.myLists.route,
                                transition: TransitionType.none),
                            child: ProfileListItem(
                              icon: LineAwesomeIcons.user_plus,
                              text: 'Invite a friend to join us',
                            ),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => AppRouter.router.navigateTo(
                                context, AppRoutes.updateProfile.route,
                                transition: TransitionType.none),
                            child: ProfileListItem(
                              icon: LineAwesomeIcons.alternate_pencil,
                              text: 'Update Profile',
                            ),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => AppRouter.router.navigateTo(
                                context, AppRoutes.introduction.route,
                                transition: TransitionType.none),
                            child: ProfileListItem(
                              icon: LineAwesomeIcons.info,
                              text: 'Introduction',
                            ),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => AppRouter.router.navigateTo(
                                context, AppRoutes.passwordChange.route,
                                transition: TransitionType.none),
                            child: ProfileListItem(
                              icon: LineAwesomeIcons.key,
                              text: 'Change password',
                            ),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => AppRouter.router.navigateTo(
                                context, AppRoutes.myLists.route,
                                transition: TransitionType.none),
                            child: ProfileListItem(
                              icon: LineAwesomeIcons.question_circle,
                              text: 'Help & Support',
                            ),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => AppRouter.router.navigateTo(
                                context, AppRoutes.myLists.route,
                                transition: TransitionType.none),
                            child: ProfileListItem(
                              icon: LineAwesomeIcons.user_shield,
                              text: 'Privacy policy',
                            ),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => AppRouter.router.navigateTo(
                                context, AppRoutes.login.route,
                                transition: TransitionType.none),
                            child: ProfileListItem(
                              icon: LineAwesomeIcons.alternate_sign_out,
                              text: 'Log Out',
                              hasNavigation: false,
                            ),
                          ),
                        ),
                  Footer()
                      ],
                    ),
<<<<<<< HEAD
                  ),
                ],
              );
},
    ))
>>>>>>> 262a0f9 (commit 2)
<<<<<<< HEAD
>>>>>>> d329a0a (commit)
=======
=======
                  );
                })
>>>>>>> be56b39 (build done features profiles)
>>>>>>> 99df823 (commit)
          ],
        ));
      },
    ));
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;

  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 5)
          .copyWith(bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).backgroundColor),
      child: Row(
        children: <Widget>[
          Icon(
            this.icon,
            size: 25,
          ),
          SizedBox(width: 25),
          Text(this.text,
              style: kTitleTextStyle.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 17)),
          Spacer(),
          if (this.hasNavigation) Icon(LineAwesomeIcons.angle_right, size: 25)
        ],
      ),
    );
  }
}
