import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabulary_learning_app/Screens/Shared/footer.dart';
import 'package:vocabulary_learning_app/Screens/Shared/nav_bar.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';

class ListWord extends StatefulWidget {
  final String _listId;
  const ListWord(String listId) : _listId = listId;
  @override
  _ListWord createState() => _ListWord(_listId);
}

class _ListWord extends State<ListWord> {
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

  final String _listId;
  _ListWord(String listId) : _listId = listId;
  List<Map<dynamic, dynamic>> lists = [];
  CollectionReference firebaseinstance;
  bool isloop = false;
  List<TextEditingController> wordcontrollers = [];
  List<TextEditingController> definecontrollers = [];
  List<String> keys = [];
  TextEditingController addword = new TextEditingController();
  TextEditingController adddefine = new TextEditingController();
  TextEditingController addlevel = new TextEditingController();

  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    firebaseinstance = FirebaseFirestore.instance.collection('lists/${_listId}/words');
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
              padding: EdgeInsets.symmetric(horizontal: 180, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                          'List Word',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 34,
                          ),
                        )
                      ],
                    )
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 600,
                    ),
                    child: FutureBuilder<QuerySnapshot>(
                      future: firebaseinstance.get(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                        if(snapshot.hasError)
                        {
                          return Text("Something went wrong");
                        }
                        if(snapshot.connectionState == ConnectionState.waiting && isloop == false)
                        {
                          return Text("loading");
                        }
                        isloop = true;
                        lists.clear();
                        for (var document in snapshot.data.docs) {
                          keys.add(document.id);
                          lists.add(document.data());
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildtable(lists, screenSize),
                            Padding(
                              padding: EdgeInsets.only(top: 35, left: 20),
                              child: Text("Add words", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(height: 20,),
                            Wrap(
                              spacing: screenSize.width*0.015,
                              children: [
                                Container(
                                  width: screenSize.width*0.2,
                                  child: TextFormField(
                                    controller: addword,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "Word",
                                      labelText: "Word",
                                      labelStyle: TextStyle(color: Colors.black),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                                    ),
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Container(
                                  width: screenSize.width*0.2,
                                  child: TextFormField(
                                    controller: adddefine,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "Definition",
                                      labelText: "Definition",
                                      labelStyle: TextStyle(color: Colors.black),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                                    ),
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Container(
                                  width: screenSize.width*0.2,
                                  child: TextFormField(
                                    controller: addlevel,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "Level",
                                      labelText: "Level",
                                      labelStyle: TextStyle(color: Colors.black),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                                    ),
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(width: screenSize.width*0.015,),
                                FloatingActionButton(
                                  child: Icon(Icons.add, size: 28, color: Colors.white,),
                                  onPressed: () {
                                    setState(() {
                                      if(addword.text != "" && adddefine.text != "" && addlevel.text != "")
                                      {
                                        firebaseinstance.add({
                                          "word": addword.text,
                                          "definition": adddefine.text,
                                          "level": int.parse(addlevel.text), "created_at": Timestamp.now()
                                        });
                                      }
                                    });
                                  },
                                  backgroundColor: Colors.blue[300],
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // HomePage footer
            Footer(),
          ],
        ),
      ),
    );
  }
  Widget buildtable(List<Map<dynamic, dynamic>> list, Size size)
  {
    wordcontrollers.clear();
    for (var i = 0; i < list.length; i++) {
      wordcontrollers.add(new TextEditingController());
    }
    definecontrollers.clear();
    for (var i = 0; i < list.length; i++) {
      definecontrollers.add(new TextEditingController());
    }
    for (var i = 0; i < list.length; i++) {
      wordcontrollers[i].text = list[i]["word"];
      definecontrollers[i].text = list[i]["definition"];
    }
    return Container(
      width: size.width*0.8,
      child: DataTable(
        sortColumnIndex: 0,
        sortAscending: true,
        columns: [
          DataColumn(
              label: Text('Word',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Definition',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ))),
          DataColumn(
              label: Text('Level',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Edit',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Delete',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold))),
        ],
        rows: [
          for (var i = 0; i < list.length; i++)
            DataRow(cells: <DataCell>[
              DataCell(
                TextFormField(
                  controller: wordcontrollers[i],
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none
                  ),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                showEditIcon: true,
              ),
              DataCell(
                  TextFormField(
                    controller: definecontrollers[i],
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none
                    ),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  showEditIcon: true),
              DataCell(Text("${list[i]['level']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),)),
              DataCell(
                TextButton(
                  child: Text(
                    "Edit",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      firebaseinstance.doc(keys[i]).update({"word": wordcontrollers[i].text,
                      "definition": definecontrollers[i].text}).catchError((onError) { print("onError"); });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  )
                ),
              ),
              DataCell(
                TextButton(
                  child: Text(
                    "Delete",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      firebaseinstance.doc(keys[i]).delete().catchError((onError) { print("onError"); });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  )
                ),
              ),
            ]),
        ]
      ),
    );
  }
}
