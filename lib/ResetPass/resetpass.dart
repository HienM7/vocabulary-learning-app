import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';

class ResetPass extends StatefulWidget {
  @override
  _ResetPass createState() => _ResetPass();
}

class _ResetPass extends State<ResetPass> {
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
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  TextEditingController _emailController = new TextEditingController();

  var _emailerr = "email khong hop le";

  var _emailinvalid = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'VocabLearn | Reset Password',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 120, 0, 40),
                  child: Container(
                      width: 130,
                      height: 130,
                      // padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle, color: Color(0xffd8d8d8)),
                      child: InkWell(
                          onTap: () => AppRouter.router.navigateTo(
                              context, AppRoutes.home.route,
                              transition: TransitionType.none),
                          child: Image.asset(
                              'assets/images/VocabLearn_logo_Wix.jpg')))),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Text(
                  "RESET PASSWORD",
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
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: onSendRequest,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                        textStyle: MaterialStateProperty.all(
                            TextStyle(color: Colors.white)),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(0))),
                    child: Text(
                      "Send Request",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () => AppRouter.router.navigateTo(
                          context, AppRoutes.login.route,
                          transition: TransitionType.none),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text(
                          "LOGIN SCREEN",
                          style: TextStyle(fontSize: 15, color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSendRequest() async {
    setState(() {
      if (_emailController.text.length < 6 ||
          !_emailController.text.contains("@"))
        _emailinvalid = true;
      else
        _emailinvalid = false;
    });
    if (!_emailinvalid)
      try {
        await auth
            .sendPasswordResetEmail(email: _emailController.text)
            .then((_) {
          AppRouter.router.navigateTo(context, AppRoutes.login.route,
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
