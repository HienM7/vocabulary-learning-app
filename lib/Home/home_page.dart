import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:vocabulary_learning_app/Screens/Shared/footer.dart';
import 'package:vocabulary_learning_app/Screens/Shared/nav_bar.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';
import 'package:vocabulary_learning_app/Home/widgets/drawer.dart';

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
          context, AppRoutes.emailNotVerified.route);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuth();
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
    change = true;
    if (value.length == 0) {
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
            List<String> strs = [];
            String str = "";
            for (int i = 0;
                i < document.data()["name"].toString().length;
                i++) {
              str += document.data()["name"][i];
              strs.add(str);
            }
            strs.forEach((element) {
              if (element == value.toString()) {
                lists.add(document.data());
                keys.add(document.id);
              }
            });
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
    SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
      label: 'VocabLearn',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //App bar
      appBar: screenSize.width > 800 ?
      PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: NavBar(),
      )
      : AppBar(
        backgroundColor: Colors.blueGrey[700],
        elevation: 0,
        centerTitle: true,
        title: Text(' VOCABLEARN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            iconSize: 36,
            color: Colors.yellow[600],
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: (){},
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: DrawerHome(),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width*0.1, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //screensize larger
                  screenSize.width > 800 ?
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => AppRouter.router.navigateTo(
                          context, AppRoutes.homePage.route,
                          transition: TransitionType.none),
                        child: Text('Home',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(width: screenSize.width*0.30),
                      TextButton(
                        onPressed: () => AppRouter.router.navigateTo(
                          context, AppRoutes.wordListDetailOrNew.route,
                          transition: TransitionType.none),
                        child: Text(
                          'Create a list',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: screenSize.width*0.015, vertical: screenSize.width*0.01)),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent[700]),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: Colors.greenAccent[700])
                            )
                          )
                        ),
                      ),
                      SizedBox(width: screenSize.width*0.05),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: screenSize.width*0.21,
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
                                Navigator.of(context).pop();
                              },
                            ),
                            contentPadding: EdgeInsets.only(left: 25),
                            hintText: "Search by list name",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                      ),
                    ],
                  )
                  //screensize small
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
                            child: Text('Home',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          SizedBox(width: screenSize.width*0.36),
                          TextButton(
                            onPressed: () => AppRouter.router.navigateTo(
                              context, AppRoutes.wordListDetailOrNew.route,
                              transition: TransitionType.none),
                            child: Text(
                              'Create a list',
                              style: TextStyle(color: Colors.white, fontSize: 14)),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent[700]),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                  side: BorderSide(color: Colors.greenAccent[700])
                                )
                              )
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: screenSize.width*0.78,
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
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //screensize larger
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
                  //screensize small
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
                  // card list publish
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 500,
                    ),
                    child: FutureBuilder<QuerySnapshot>(
                      future: firebaseinstance.get(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
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
                                                top: 15, bottom: 10, left: 15),
                                            child: Text(
                                              lists[i]['name'],
                                              style: TextStyle(
                                                fontSize: 19,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
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
}
