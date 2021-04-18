import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final auth = FirebaseAuth.instance;

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK')
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  bool _showPass = false;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  var _emailerr = "email khong hop le";
  var _passerr = "pass phai tren 6 ki tu";
  var _emailinvalid = false;
  var _passinvalid = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
      label: 'VocabLearn | Login',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          // constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Container(
                    width: 130,
                    height: 130,
                    // padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle, color: Color(0xffd8d8d8)),
                    child: Image.asset('assets/images/VocabLearn_logo_Wix.jpg'))
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: TextField(
                  controller: _emailController,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                      errorText: _emailinvalid ? _emailerr : null,
                      labelText: "EMAIL",
                      labelStyle:
                          TextStyle(color: Color(0xff888888), fontSize: 15)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    TextField(
                      controller: _passController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      obscureText: !_showPass,
                      decoration: InputDecoration(
                          errorText: _passinvalid ? _passerr : null,
                          labelText: "PASSWORD",
                          labelStyle: TextStyle(
                              color: Color(0xff888888), fontSize: 15)),
                    ),
                    GestureDetector(
                      onTap: onToggleShowPass,
                      child: Text(
                        _showPass ? "HIDE" : "SHOW",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: onSignInClicked,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(color: Colors.white)),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(0))
                    ),
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              Container(
                height: 130,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () => AppRouter.router.navigateTo(
                        context, AppRoutes.signup.route,
                        transition: TransitionType.none),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text(
                          "NEW USER ? SIGN UP",
                          style: TextStyle(fontSize: 15, color: Colors.blue),
                        ),
                      ),
                    ),
                    Text(
                      "FORGOT PASSWORD ?",
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  Future<void> onSignInClicked() async {
    setState(() {
      if (_emailController.text.length < 6 ||
          !_emailController.text.contains("@"))
        _emailinvalid = true;
      else
        _emailinvalid = false;

      if (_passController.text.length < 6)
        _passinvalid = true;
      else
        _passinvalid = false;
    });
    if (!_emailinvalid && !_passinvalid)
      try {
        await auth
            .signInWithEmailAndPassword(
                email: _emailController.text, password: _passController.text)
            .then((_) {
          // AppRouter.router.navigateTo(
          //   context, AppRoutes.homeAuth.route,
          //   transition: TransitionType.none);
          AppRouter.router.navigateTo(
            context, AppRoutes.homePage.route,
            transition: TransitionType.none);
        });
      } catch (e) {
        showError(e.message);
        print(e);
      }
  }
}
// Navigator.of(context).pushReplacement(
//     MaterialPageRoute(builder: (context) => HomePage()));
