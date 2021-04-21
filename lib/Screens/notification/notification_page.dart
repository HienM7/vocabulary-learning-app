import 'dart:collection';
import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:vocabulary_learning_app/Screens/Shared/footer.dart';
import 'package:vocabulary_learning_app/Screens/Shared/nav_bar.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';
import 'package:vocabulary_learning_app/Home/widgets/drawer.dart';
import 'package:vocabulary_learning_app/services/notification.dart';

class NotificationPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<NotificationPage> {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final NotifService notifService = NotifService();

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

  void actionDone(DocumentSnapshot notif, String actionText) {
    notifService.update(notif, {"seen": true});

    if (notif.data()["type"].toLowerCase() == "invite") {
      if (actionText == "accept") {
        fireStore
        .collection("lists")
        .doc(notif.data()["action_data"]["list_id"])
        .update({
          "collab_ids": FieldValue.arrayUnion(
            [auth.currentUser.uid])
        });
      }
    }
  }

  static const int PG_SIZE = 5;
  List<DocumentSnapshot> shownDocs = [];
  Map<DocumentSnapshot,bool> pressed = new LinkedHashMap();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
      label: 'VocabLearn | Notifications',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //App bar
      appBar: screenSize.width > 800 ?
        PreferredSize(
          preferredSize: Size(screenSize.width, 1000),
          child: NavBar(),
        ) :
        AppBar(
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
                  
                  // for large screen sizes
                  screenSize.width > 800 ?
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_none_outlined,
                          size: 40,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 20,),
                        Text(
                          'Your Notifications',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 34,
                          ),
                        ),
                      ],
                    ),
                  ) :
                  // for small screen sizes
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_none_outlined,
                          size: 30,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 13,),
                        Text(
                          'Your Notifications',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                          ),
                        ),
                      ],
                    )
                  ),

                  // Notif list
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 500,
                    ),
                    child: FutureBuilder<QuerySnapshot>(
                      future: notifService.fetchBatch(
                        auth.currentUser.uid,
                        shownDocs,
                        PG_SIZE
                      ),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          //>>>
                          print(snapshot.error);
                          print(snapshot.stackTrace);
                          //>>>
                          return Text("Something went wrong");
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text("Loading...");
                        }

                        // shownDocs.addAll(snapshot.data.docs);
                        for (var notif in snapshot.data.docs) {
                          shownDocs.add(notif);
                          pressed[notif] = notif.data()["seen"];
                        }
                        //>>>
                        print(snapshot.data.size);
                        //>>>

                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 500,
                          ),
                          child: Column(
                            children: [
                              Wrap(spacing: 10, runSpacing: 10, children: [
                                for (var notif in shownDocs)
                                  Card(
                                    margin: EdgeInsets.all(12),
                                    borderOnForeground: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    color: Colors.grey[100],
                                    child: Column(
                                      crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(12),
                                          child: TextButton(
                                            onPressed: () {},  // show Sender
                                            child: Container(
                                              width: screenSize.width*0.64,
                                              child: Text(
                                                notif.data()["type"] == "invite" ?
                                                "Collaboration Invitation" :
                                                notif.data()["type"] == "update" ?
                                                "App Updates" :
                                                "General Notification",
                                                style: TextStyle(
                                                  fontSize: 20
                                                )
                                              )
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 12,
                                            right: 12,
                                            bottom: 12
                                          ),
                                          child: Text(
                                            timeago.format(
                                              notif
                                              .data()["created_at"]
                                              .toDate()
                                            ),
                                            style: TextStyle(
                                              color: Colors.black54)
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(12),
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 8),
                                            child: Text(
                                              notif.data()["content"],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(12),
                                          child: Row(
                                            children: [
                                            
                                            if (!notif.data()["seen"])
                                            for (var actionText in notif.data()["actions"])
                                            Padding(
                                              padding: EdgeInsets.only(right: 12),
                                              child: TextButton(
                                                child: Text(
                                                  " " + actionText + " ",
                                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                                ),
                                                onPressed:
                                                // notif.data()["seen"]
                                                pressed[notif]
                                                ? () {}
                                                : () {
                                                  setState(() {
                                                    pressed[notif] = true;
                                                    // notif.data()["seen"] = true;
                                                  });
                                                  return actionDone(
                                                    notif,
                                                    actionText.toLowerCase()
                                                  );
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                    // notif.data()["seen"]
                                                    pressed[notif]
                                                    ? MaterialStateProperty
                                                    .all<Color>(Colors.grey[400])
                                                    : MaterialStateProperty
                                                    .all<Color>(
                                                      actionText.toLowerCase() == "accept" ? Colors.greenAccent[400] :
                                                      actionText.toLowerCase() == "decline" ?
                                                      Colors.redAccent[400] :
                                                      actionText.toLowerCase() == "ok" ?
                                                      Colors.blueAccent[400] :
                                                      Colors.grey[400]
                                                    ),
                                                  padding: MaterialStateProperty
                                                    .all<EdgeInsets>(EdgeInsets.all(2)),
                                                ),
                                              ),
                                            ),

                                            ]
                                          )
                                        ),
                                      ],
                                    ),
                                  )
                              ]),
                              
                              if (snapshot.data.size == PG_SIZE)
                                Container(
                                  width: screenSize.width*0.24,
                                  height: 50,
                                  margin: EdgeInsets.only(top: 30),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
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
                                          "Load older notifications",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                        MaterialStateProperty
                                        .all<Color>(Colors.grey[200]),
                                      shape:
                                        MaterialStateProperty
                                        .all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                              BorderRadius.circular(10),
                                            side: BorderSide(
                                                color: Colors.amber)
                                          )
                                        )
                                    ),
                                  )
                                )
                              else
                                Wrap()
                            ],
                          )
                        );
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
