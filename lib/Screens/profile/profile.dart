// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vocabulary_learning_app/constants/constants.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    var profileInfo = Expanded(
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
          'Viet Huynh',  // --> user.name
          style: kTitleTextStyle,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'huynhvanviet317@gmail.com',  // --> user.email
          style: kCaptionTextStyle,
        ),
        SizedBox(
          height: 7,
        ),
      ]),
    );

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
            Icon(
              LineAwesomeIcons.arrow_left,
              size: 40,
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
              child: ListView(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => AppRouter.router.navigateTo(
                      context, AppRoutes.myLists.route),
                    child: ProfileListItem(
                      icon: LineAwesomeIcons.history,
                      text: 'Your Word Lists',
                    ),
                  ),
                  ProfileListItem(
                    icon: LineAwesomeIcons.user_plus,
                    text: 'Invite a friend to join us',
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
                    text: 'Log Out',
                    hasNavigation: false,
                  ),
                ],
              ),
            ),
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
