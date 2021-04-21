import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vocabulary_learning_app/Home/widgets/drawer.dart';
import 'package:vocabulary_learning_app/Screens/Shared/footer.dart';
import 'package:vocabulary_learning_app/Screens/Shared/nav_bar.dart';
import 'package:vocabulary_learning_app/Screens/profile/profile.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';
import 'package:vocabulary_learning_app/services/database.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfilePage createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfile> {
  String code;
  String dialCode;
  String name;
  String email;
<<<<<<< HEAD
=======
  String password;
>>>>>>> 99df823 (commit)
  static String userName = " ";
  String id;
  bool _isEditingText = false;
  TextEditingController username; 

  @override
  void dispose() {
    username.dispose();
    super.dispose();
  }

  bool isloop = false;
  bool isCheck = false;

  static String userId = FirebaseAuth.instance.currentUser.uid;

  CollectionReference firebaseinstance =
      FirebaseFirestore.instance.collection('profiles');

  DocumentReference docRef =
      FirebaseFirestore.instance.collection('users').doc('uid');
<<<<<<< HEAD
  
=======
>>>>>>> 99df823 (commit)
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 300).copyWith(bottom: 20),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Container(
                  width: 130,
                  height: 130,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xffd8d8d8)),
                  child: Image.asset('assets/images/VocabLearn_logo_Wix.jpg')),
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
                    id = document.id;
                    code = document['code'];
                    dialCode = document['dialCode'];
                    name = document['name'];
                    userName = document['display_name'];
                  }
                }
                username = new TextEditingController(text: userName);
                return Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: TextField(
                          controller: username,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          keyboardType: TextInputType.name,
                          onChanged: (val) {
                              userName = val; 
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
                          initialSelection: code,
                          favorite: [dialCode, code],
                          // optional. Shows only country name and flag
                          showCountryOnly: true,
                          // optional. Shows only country name and flag when popup is closed.
                          showOnlyCountryWhenClosed: true,
                          // optional. aligns the fla g and the Text left
                          alignLeft: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                            width: 900,
                            height: 56,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      height: 50,
                                      child: RaisedButton(
                                        color: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        onPressed: () {
                                          firebaseinstance.doc(id).update({
                                            "display_name": username.text == ""
                                                ? userName
                                                : username.text,
                                            "code": code,
                                            "dialCode": dialCode,
                                            "name": name,
                                          }).catchError((onError) {
                                            print("onError");
                                          });
                                          AppRouter.router.navigateTo(context,
                                              AppRoutes.myProfile.route,
                                              transition: TransitionType.none);
                                        },
                                        child: Text(
                                          "Update",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    SizedBox(
                                      width: 120,
                                      height: 49,
                                      child: RaisedButton(
                                        color: Colors.red,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        onPressed: () => AppRouter.router
                                            .navigateTo(context,
                                                AppRoutes.myProfile.route,
                                                transition:
                                                    TransitionType.none),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
