// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vocabulary_learning_app/constants/constants.dart';
import 'package:vocabulary_learning_app/services/database.dart';

String uId = "i2uEzQDBu9GIjnjNnAMr";

class Introduction extends StatefulWidget {
  @override
  _IntroductionPage createState() => _IntroductionPage();
}

class _IntroductionPage extends State<Introduction> {
  Stream userStream;
  String code;
  String dialCode;
  String name;
  String email;
  String password;

  DatabaseServices databaseServices = new DatabaseServices();

  @override
  void initState() {
    databaseServices.getUserInfo(uId).then((val) {
      print(val);
      userStream = val;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    var profileInfo = StreamBuilder(
        stream: userStream,
        builder: (context, snapshot) {
          print(snapshot);
          this.code = snapshot.data["code"];

          this.dialCode = snapshot.data["dialCode"];

          this.name = snapshot.data["name"];

          this.email = snapshot.data["email"];
          this.password = snapshot.data["password"];
          return Expanded(
            child: Column(children: [
              Container(
                height: 120,
                width: 120,
                margin: EdgeInsets.only(top: 50),
                child: Stack(children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/images/img.png'),
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
                snapshot.data["username"],
                style: kTitleTextStyle,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                snapshot.data["email"],
                style: kCaptionTextStyle,
              ),
              SizedBox(
                height: 7,
              ),
            ]),
          );
        });

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
                  Navigator.pushNamed(context, '/my-profile');
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
            StreamBuilder(
                stream: userStream,
                builder: (context, snapshot) {
                  this.code = snapshot.data["code"];

                  this.dialCode = snapshot.data["dialCode"];

                  this.name = snapshot.data["name"];
                  return Expanded(
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: CountryCodePicker(
                            onChanged: print,
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: snapshot.data["code"],
                            favorite: [
                              snapshot.data["dialCode"],
                              snapshot.data["code"]
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
                        IntroductionItem(
                          text: 'Introduction 1',
                        ),
                        IntroductionItem(
                          text: 'Introduction 2',
                        ),
                        IntroductionItem(
                          text: 'Introduction 3',
                        ),
                        IntroductionItem(
                          text: 'Introduction 4',
                        ),
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
      height: 50,
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
