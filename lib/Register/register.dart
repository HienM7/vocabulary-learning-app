import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabulary_learning_app/Home/home_test_auth.dart';
import 'package:vocabulary_learning_app/Login/login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final auth = FirebaseAuth.instance;
  checkAuthentication() async {
    auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.pushNamed(context, '/home-page');
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
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  bool _showPass = false;
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  var _usererr = "username empty";
  var _emailerr = "email khong hop le";
  var _passerr = "pass phai tren 6 ki tu";
  var _userinvalid = false;
  var _emailinvalid = false;
  var _passinvalid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
              child: Container(
                  width: 70,
                  height: 70,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xffd8d8d8)),
                  child: FlutterLogo()),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: Text(
                "CREATE YOUR ACCOUNT",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30),
                )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: Text(
                  "REGISTER",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                child: TextField(
                  controller: _userController,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                      errorText: _userinvalid ? _usererr : null,
                      labelText: "USERNAME",
                      labelStyle:
                          TextStyle(color: Color(0xff888888), fontSize: 15)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
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
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
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
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    onPressed: onSignInClicked,
                    child: Text(
                      "REGISTER",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 130,
              // ),
              Container(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () => {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => LoginPage()))
                    Navigator.pushNamed(context, '/login')
                  },
                  child: Text(
                    " YOU HAVE AN ACCOUNT ? SIGN IN",
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                ),
              ),
            ],
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

      if (_userController.text.length < 1)
        _userinvalid = true;
      else
        _userinvalid = false;
    });
    if (!_emailinvalid && !_passinvalid && !_userinvalid)
      try {
        UserCredential user = await auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passController.text);

        if (user != null) {
          await auth.currentUser
              .updateProfile(displayName: _userController.text);
          Navigator.pushNamed(context, '/home-page');
          // await Navigator.pushReplacementNamed(context,"/") ;
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => HomePageAuth()));
        }
      } catch (e) {
        showError(e.message);
        print(e);
      }
  }
}
