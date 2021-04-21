import 'dart:async';
import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabulary_learning_app/Screens/Shared/footer.dart';
import 'package:vocabulary_learning_app/Screens/Shared/nav_bar.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';
import 'package:vocabulary_learning_app/Home/widgets/drawer.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePageUser extends StatefulWidget {
  @override
  _HomePageStateUser createState() => _HomePageStateUser();
}

class _HomePageStateUser extends State<HomePageUser> {
  final auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;
  checkAuth() async {
    auth.authStateChanges().listen((user) {
      // not logged in
      if (user == null) {
        AppRouter.router.navigateTo(
          context, AppRoutes.login.route,
          transition: TransitionType.none);
      }
      // not verified
      else if (!user.emailVerified) {
        AppRouter.router.navigateTo(
          context, AppRoutes.emailNotVerified.route,
          transition: TransitionType.none);
      }
    });
  }
  

  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      this.checkAuth();
    });

    super.initState();
  }

  List<Map<dynamic, dynamic>> lists = [];
  List<String> keys = [];
  CollectionReference firebaseinstance = FirebaseFirestore.instance.collection("lists");
  final TextEditingController _controller = TextEditingController();
  bool change = false;
  int limits = 9;
  bool equal = true;
  bool isloop = false;

  initiateSearch(value) {
    String searchText = value.toString().trim().toLowerCase();
    change = true;
    if (searchText.length == 0) {
      setState(() {
        lists.clear();
        firebaseinstance.get().then((querySnapshot) {
          int i = 0;
          for (var document in querySnapshot.docs) {
            lists.add(document.data());
            keys.add(document.id);
            i++;
            if (i == limits) break;
          }
          if (limits == lists.length) {
            equal = true;
          } else
            equal = false;
        });
      });
    } else {
      setState(() {
        lists.clear();
        firebaseinstance.get().then((querySnapshot) {
          querySnapshot.docs.forEach((document) {
            String listName = document.data()["name"].toString();
            if (listName.trim().toLowerCase().contains(searchText)) {
              lists.add(document.data());
              keys.add(document.id);
            }
          });
          if (limits == lists.length) {
            equal = true;
          } else
            equal = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'VocabLearn',
      primaryColor: Theme.of(context).primaryColor.value,
    ));

    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // App bar
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

      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.1, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // large screen sizes
                  screenSize.width > 800
                      ? Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => AppRouter.router.navigateTo(
                                  context, AppRoutes.homePage.route,
                                  transition: TransitionType.none),
                              child: Text(
                                'Home',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: screenSize.width * 0.32),
                            TextButton(
                              onPressed: () => AppRouter.router.navigateTo(
                                  context, AppRoutes.wordListDetailOrNew.route,
                                  transition: TransitionType.none),
                              child: Text('Create a list',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                          horizontal: screenSize.width * 0.015,
                                          vertical: screenSize.width * 0.01)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.greenAccent[700]),
                                  shape:
                                      MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              side: BorderSide(
                                                  color: Colors.greenAccent[700]
                                              )
                                          )
                                      )
                              ),
                            ),
                            SizedBox(width: screenSize.width * 0.05),
                            Container(
                              padding: EdgeInsets.all(10),
                              width: screenSize.width * 0.23,
                              child: TextField(
                                controller: _controller,
                                onSubmitted: (value) {
                                  initiateSearch(value);
                                },
                                textInputAction: TextInputAction.newline,
                                decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                    color: Colors.black,
                                    icon: Icon(Icons.search),
                                    iconSize: 20,
                                    onPressed: () {
                                      
                                    },
                                  ),
                                  contentPadding: EdgeInsets.only(left: 25),
                                  hintText: "Search by list name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                ),
                              ),
                            ),
                          ],
                        )
                      // small screen sizes
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => AppRouter.router.navigateTo(
                                      context, AppRoutes.homePage.route,
                                      transition: TransitionType.none),
                                  child: Text(
                                    'Home',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(width: screenSize.width * 0.36),
                                TextButton(
                                  onPressed: () => AppRouter.router.navigateTo(
                                      context,
                                      AppRoutes.wordListDetailOrNew.route,
                                      transition: TransitionType.none),
                                  child: Text('Create a list',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                  style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.greenAccent[700]),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              side: BorderSide(color: Colors.greenAccent[700])))),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: screenSize.width * 0.78,
                              child: TextField(
                                controller: _controller,
                                onSubmitted: (value) {
                                  initiateSearch(value);
                                },
                                textInputAction: TextInputAction.newline,
                                decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                    color: Colors.black,
                                    icon: Icon(Icons.search),
                                    iconSize: 20,
                                    onPressed: () {},
                                  ),
                                  contentPadding: EdgeInsets.only(left: 25),
                                  hintText: "Search by list name",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                              ),
                            ),
                          ],
                        ),
                  // large screen sizes
                  screenSize.width > 800 ?
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.library_books,
                          size: 40,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 20,),
                        Text(
                          'Public Word Lists',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 34,
                          ),
                        ),
                      ],
                    ),
                  )
                  // small screen sizes
                  : Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Icon(
                          Icons.library_books,
                          size: 30,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 13,),
                        Text(
                          'Public Word Lists',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                          ),
                        ),
                      ],
                    )
                  ),
                  // public card lists
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 500,
                    ),
                    child: FutureBuilder<QuerySnapshot>(
                      future: firebaseinstance.get(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          //>>>
                          print(snapshot.error);
                          //>>>
                          return Text("Something went wrong");
                        }
                        if (snapshot.connectionState ==
                                ConnectionState.waiting &&
                            isloop == false) {
                          return Text("Loading...");
                        }
                        isloop = true;
                        if (change == false) {
                          lists.clear();
                          int i = 0;
                          for (var document in snapshot.data.docs) {
                            lists.add(document.data());
                            keys.add(document.id);
                            i++;
                            if (i == limits) break;
                          }
                          if (limits == lists.length)
                          {
                            equal = true;
                          } else equal = false;
                        }
                        return ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 500,
                            ),
                            child: Column(
                              children: [
                                Wrap(spacing: 10, runSpacing: 10, children: [
                                  for (var i = 0; i < lists.length; i++)
                                    Card(
                                      borderOnForeground: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      color: Colors.grey[200],
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              AppRouter.router.navigateTo(
                                                context,
                                              AppRoutes.getDetailRoute(
                                                "/wordlists", keys[i]),
                                              transition: TransitionType.none);
                                            },
                                            child: Container(
                                                height: 200,
                                                width: 360,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: AssetImage('assets/images/home_background.jpg'),
                                                      fit: BoxFit.cover,
                                                    ))),
                                          ),
                                          Container(
                                            height: 40,
                                            margin: EdgeInsets.only(
                                                top: 15, bottom: 5, left: 15),
                                            child: Text(
                                              lists[i]['name'],
                                              style: TextStyle(
                                                fontSize: 19,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(width: 15,),
                                                TextButton(
                                                  onPressed: () {
                                                    AppRouter.router.navigateTo(
                                                      context,
                                                    AppRoutes.getDetailRoute(
                                                      "/quizpage", keys[i]),
                                                    transition: TransitionType.none);
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Row(
                                                      mainAxisAlignment:MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.games,
                                                          color: Colors.grey[600],
                                                          size: 20,
                                                        ),
                                                        SizedBox(width: 5,),
                                                        Text(
                                                          "Game",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.w400),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[200]),
                                                    side: MaterialStateProperty.all<BorderSide>(BorderSide(color: Colors.grey)),
                                                  ),
                                                ),
                                                SizedBox(width: screenSize.width*0.1,),
                                                Container(
                                                  height: 34,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                                    ),
                                                    
                                                    child: Text(
                                                      "Share List"
                                                    ),
                                                    onPressed: () async {
                                                      await share(keys[i]);
                                                    },
                                                  )
                                                ),
                                              ],
                                            )
                                          ),
                                        ],
                                      ),
                                    )
                                ]),
                                if (equal == true)
                                  Container(
                                      width: 300,
                                      height: 50,
                                      margin: EdgeInsets.only(top: 30),
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            limits += 9;
                                            initiateSearch(_controller.text);
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.sync_rounded,
                                              color: Colors.black,
                                              size: 22,
                                            ),
                                            Text(
                                              "Load more",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w300),
                                            )
                                          ],
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.grey[200]),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    side: BorderSide(
                                                        color: Colors.amber)))),
                                      ))
                                else
                                  Wrap()
                              ],
                            ));
                      },
                    ),
                  ),
                ],
              )),
          // HomePage footer
          Footer(),
        ]),
      ),
    );
  }
void share(id) {
  Codec<String, String> stringToBase64Url = utf8.fuse(base64Url);
  String encoded = stringToBase64Url.encode(id);
  Clipboard.setData(
    new ClipboardData(
      text: window.location.origin + "#" +
            AppRoutes.getDetailRoute("/wordlists-show", encoded)
    )
  ).then((_) {
      Alert(
      context: context,
      title: "ALERT",
      desc: "Copied. Now You can share the link. ",
      image: Image.asset("images/home_background.jpg"),
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
          // color: Colors.blue,
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ])
        )
      ],
    ).show();
});

 
  // await FlutterShare.share(
  //   // title: 'Share',
  //   // text: 'Share List',
  //   // linkUrl: AppRoutes.getDetailRoute("/wordlists/show", encoded),
  //   // chooserTitle: '',

  //   title: 'Example share',
  //     text: 'Example share text',
  //     linkUrl: 'https://flutter.dev/',
  //     chooserTitle: 'Example Chooser Title'
  // );
}
                                                
}
