import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vocabulary_learning_app/constants/constants.dart';
import 'package:vocabulary_learning_app/Screens/profile/profile.dart';

class MainProfile extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        initTheme: kDarkTheme,
        child: Builder(
          builder: (context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeProvider.of(context),
              home: ProfileScreen(),
            );
          },
        ));
  }
}
