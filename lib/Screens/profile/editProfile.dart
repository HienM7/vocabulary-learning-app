import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vocabulary_learning_app/Screens/profile/profile.dart';
import 'package:vocabulary_learning_app/services/database.dart';

String uId = "i2uEzQDBu9GIjnjNnAMr";

class EditProfile extends StatefulWidget {
  @override
  _EditProfilePage createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfile> {
  Stream userStream;
  String code;
  String dialCode;
  String name;
  String email;
  String password;
  TextEditingController username = new TextEditingController();

  DatabaseServices databaseServices = new DatabaseServices();

  @override
  void initState() {
    databaseServices.getUserInfo(uId).then((val) {
      userStream = val;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50).copyWith(bottom: 20),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Container(
                  width: 70,
                  height: 70,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xffd8d8d8)),
                  child: FlutterLogo()),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: Text(
                "UPDATE PROFILE",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30),
              ),
            ),
            StreamBuilder(
              stream: userStream,
              builder: (context, snapshot) {
                @override
                void dispose() {
                  // Clean up the controller when the widget is disposed.
                  username.dispose();
                  super.dispose();
                }

                this.code = snapshot.data["code"];

                this.dialCode = snapshot.data["dialCode"];

                this.name = snapshot.data["name"];

                this.email = snapshot.data["email"];
                this.password = snapshot.data["password"];

                return Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: TextField(
                          controller: username,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          onChanged: (val) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                              labelText: "USERNAME",
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 15)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: CountryCodePicker(
                          onChanged: (CountryCode countryCode) {
                            this.code = countryCode.code;
                            this.dialCode = countryCode.dialCode;
                            this.name = countryCode.name;
                          },
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
                          // optional. aligns the fla g and the Text left
                          alignLeft: false,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SizedBox(
                  width: 600,
                  height: 56,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: RaisedButton(
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              onPressed: onProfileUpdateClick,
                              child: Text(
                                "Update",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: RaisedButton(
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              onPressed: onProfileClick,
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void onProfileClick() {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: profileScreen));
    });
  }

  void onProfileUpdateClick() {
    Map<String, dynamic> userMap = {
      "username": username.text,
      "code": code,
      "dialCode": dialCode,
      "name": name,
      "email": email,
      "password": password
    };

    DatabaseServices().updateUserInfo(uId, userMap);
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: profileScreen));
    });
  }

  Widget profileScreen(BuildContext context) {
    return ProfileScreen();
  }
}
