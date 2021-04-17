import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabulary_learning_app/Screens/vocab_list/vocab_list.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';


// NewCourseInfoPage
class CoursePage extends StatefulWidget {
  @override
  _CoursePage createState() => _CoursePage();
}

class _CoursePage extends State<CoursePage> {
  final auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;
  checkAuth() async {
    auth.authStateChanges().listen((user) {
      // not logged in
      if (user == null) {
        AppRouter.router.navigateTo(
          context, AppRoutes.login.route);
      }
      // not verified
      else if (!user.emailVerified) {
        AppRouter.router.navigateTo(
          context, AppRoutes.emailNotVerified.route);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuth();
  }
  
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _desController = new TextEditingController();
  TextEditingController _tagController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vocab list')),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: Text(
                "Create new Course",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
              child: TextField(
                controller: _nameController,
                style: TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle:
                        TextStyle(color: Color(0xff888888), fontSize: 15)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
              child: TextField(
                controller: _tagController,
                style: TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Description",
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
                    controller: _desController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "Tag",
                        labelStyle:
                            TextStyle(color: Color(0xff888888), fontSize: 15)),
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
                  onPressed: onCreateCourse,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade300),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                    textStyle: MaterialStateProperty.all(
                      TextStyle(color: Colors.white)),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.all(0))
                  ),
                  child: Text(
                    "Create",
                    style: TextStyle(color: Colors.white, fontSize: 16),
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
    );
  }

  void onCreateCourse() {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: gotoVocabList));
    });
  }

  Widget gotoVocabList(BuildContext context) {
    return TablePage();
  }
}
