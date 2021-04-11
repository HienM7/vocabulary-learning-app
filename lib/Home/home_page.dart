import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabulary_learning_app/Screens/Shared/footer.dart';
import 'package:vocabulary_learning_app/Screens/Shared/nav_bar.dart';

class HomePageUser extends StatefulWidget {
  @override
  _HomePageStateUser createState() => _HomePageStateUser();
}

class _HomePageStateUser extends State<HomePageUser> {
  final auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;
  checkAuthentification() async {
    auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushNamed(context, '/login');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  List<Map<dynamic, dynamic>> lists = [];
  CollectionReference firebaseinstance =
      FirebaseFirestore.instance.collection('list');
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
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //App bar
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: NavBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width*0.12, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Home',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: screenSize.width*0.30),
                      TextButton(
                        child: Text('Create a list', style: TextStyle(color: Colors.white, fontSize: 18),),
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
                            hintText: "Search by name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'List Public',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 34,
                            ),
                          )
                        ],
                      )),
                  // card list publish
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 500,
                    ),
                    child: FutureBuilder<QuerySnapshot>(
                      future: firebaseinstance.get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }
                        if (snapshot.connectionState ==
                                ConnectionState.waiting &&
                            isloop == false) {
                          return Text("loading");
                        }
                        isloop = true;
                        if (change == false) {
                          lists.clear();
                          int i = 0;
                          for (var document in snapshot.data.docs) {
                            lists.add(document.data());
                            i++;
                            if (i == limits) break;
                          }
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
                                            onPressed: () {},
                                            child: Container(
                                                height: 200,
                                                width: 360,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          lists[i]
                                                              ['url_image']),
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
