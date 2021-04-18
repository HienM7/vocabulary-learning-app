// ignore: avoid_web_libraries_in_flutter
import 'dart:async';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vocabulary_learning_app/constants/constants.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';
import 'package:vocabulary_learning_app/services/database.dart';

String uId = "i2uEzQDBu9GIjnjNnAMr";

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenPage createState() => _ProfileScreenPage();
}

class _ProfileScreenPage extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'VocabLearn | Profile',
      primaryColor: Theme.of(context).primaryColor.value,
    ));

  CollectionReference firebaseInstance =
      FirebaseFirestore.instance.collection('profiles');
  bool equal = true;
  bool isLoop = false;

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('users')
      .doc('BXdTNFyd2gajVD4JI4N5EKrVPLA3');

  @override
  Widget build(BuildContext context) {
    print(firebaseInstance);
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    var profileInfo = Expanded(
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

    var themeSwitcher = ThemeSwitcher(builder: (context) {
      return AnimatedCrossFade(
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
          ));
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
                onTap: () {
                  Navigator.pushNamed(context, '/home-page');
                },
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
        return Scaffold(
            body: Column(
          children: <Widget>[
            SizedBox(height: 15),
            header,

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
                          ),
                        ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, '/my-profile/introduction');
                      },
                      child: ProfileListItem(
                        icon: LineAwesomeIcons.info,
                        text: 'Introduction',
                      ),
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/edit-profile');
                      },
                      child: ProfileListItem(
                        icon: LineAwesomeIcons.edit,
                        text: 'Edit Profile',
                      ),
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        print('press button');
                      },
                      child: ProfileListItem(
                        icon: LineAwesomeIcons.key,
                        text: 'Change password',
                      ),
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        print('press button');
                      },
                      child: ProfileListItem(
                        icon: LineAwesomeIcons.question_circle,
                        text: 'Help & Support',
                      ),
                    ),

                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        print('press button');
                      },
                      child: ProfileListItem(
                        icon: LineAwesomeIcons.user_shield,
                        text: 'Privacy policy',
                      ),
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        print('press button');
                      },
                      child: ProfileListItem(
                        icon: LineAwesomeIcons.alternate_sign_out,
                        text: 'Logout',
                        hasNavigation: false,
                      ),
                    ),
                  ),
                ],
              );
},
    ))
          ],
        ));
      },
    ));
  }
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