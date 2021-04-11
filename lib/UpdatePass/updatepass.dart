import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';

class UpdatePassPage extends StatefulWidget {
  @override
  _UpdatePassPage createState() => _UpdatePassPage();
}

class _UpdatePassPage extends State<UpdatePassPage> {
  final auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentication() async {
    auth.authStateChanges().listen((user) async {
      if (user == null) {
        AppRouter.router.navigateTo(
          context, AppRoutes.login.route);
      }
    });
  }

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

  getUser() async {
    User firebaseUser = auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
    this.getUser();
  }

  bool _showPass1 = false;
  bool _showPass2 = false;
  bool _showPass3 = false;
  TextEditingController _passController = new TextEditingController();
  TextEditingController _newpassController = new TextEditingController();
  TextEditingController _renewpassController = new TextEditingController();
  var _passerr = "pass phai tren 6 ki tu";
  var _newpasserr = "newpass phai tren 6 ki tu";
  var _renewpasserr = "renewpass phai tren 6 ki tu";
  var _renewpassinvalid = false;
  var _newpassinvalid = false;
  var _passinvalid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          // constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 90, 0, 40),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(70, 0, 0, 50),
                child: Text(
                  "UPDATE PASSWORD",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    TextField(
                      controller: _passController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      obscureText: !_showPass1,
                      decoration: InputDecoration(
                          errorText: _passinvalid ? _passerr : null,
                          labelText: "PASSWORD",
                          labelStyle: TextStyle(
                              color: Color(0xff888888), fontSize: 15)),
                    ),
                    GestureDetector(
                      onTap: onToggleShowPass1,
                      child: Text(
                        _showPass1 ? "HIDE" : "SHOW",
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
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    TextField(
                      controller: _newpassController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      obscureText: !_showPass2,
                      decoration: InputDecoration(
                          errorText: _newpassinvalid ? _newpasserr : null,
                          labelText: "NEW PASSWORD",
                          labelStyle: TextStyle(
                              color: Color(0xff888888), fontSize: 15)),
                    ),
                    GestureDetector(
                      onTap: onToggleShowPass2,
                      child: Text(
                        _showPass2 ? "HIDE" : "SHOW",
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
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    TextField(
                      controller: _renewpassController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      obscureText: !_showPass3,
                      decoration: InputDecoration(
                          errorText: _renewpassinvalid ? _renewpasserr : null,
                          labelText: "REPEAT NEWPASSWORD",
                          labelStyle: TextStyle(
                              color: Color(0xff888888), fontSize: 15)),
                    ),
                    GestureDetector(
                      onTap: onToggleShowPass3,
                      child: Text(
                        _showPass3 ? "HIDE" : "SHOW",
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
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: onUpdateClicked,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(color: Colors.white)),
                    ),
                    child: Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 130,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void onToggleShowPass1() {
    setState(() {
      _showPass1 = !_showPass1;
    });
  }

  void onToggleShowPass2() {
    setState(() {
      _showPass2 = !_showPass2;
    });
  }

  void onToggleShowPass3() {
    setState(() {
      _showPass3 = !_showPass3;
    });
  }

  // ignore: missing_return

  Future<void> onUpdateClicked() async {
    setState(() {
      if (_passController.text.length < 6)
        _passinvalid = true;
      else
        _passinvalid = false;

      if (_newpassController.text.length < 6)
        _newpassinvalid = true;
      else
        _newpassinvalid = false;

      if (_renewpassController.text.length < 6)
        _renewpassinvalid = true;
      else
        _renewpassinvalid = false;
    });

    user = auth.currentUser;
    var authCredentials = EmailAuthProvider.credential(
        email: user.email, password: _passController.text);
    try {
      var authResult = await user.reauthenticateWithCredential(authCredentials);
      if (authResult.user != null) if (!_passinvalid &&
          !_newpassinvalid &&
          !_renewpassinvalid) if (_newpassController
              .text ==
          _renewpassController.text) {
        try {
          await user.updatePassword(_newpassController.text);
          AppRouter.router.navigateTo(
            context, AppRoutes.myProfile.route);
          // AppRouter.router.navigateTo(
          //   context, AppRoutes.homeAuth.route);
        } catch (e) {
          showError(e.message);
          print(e);
        }
      }
    } catch (e) {
      showError(e.message);
      print(e);
      return false;
    }
  }
}
