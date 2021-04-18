import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';
import 'package:vocabulary_learning_app/services/database.dart';

class ToDoTestPage extends StatefulWidget {
  final String username;
  final String userEmail;
  ToDoTestPage({this.username, this.userEmail});

  @override
  _ToDoTestPageState createState() => _ToDoTestPageState();
}

String uId = "abcdefTestUserID";

class _ToDoTestPageState extends State<ToDoTestPage> {
  final auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;
  checkAuthentification() async {
    auth.authStateChanges().listen((user) {
      if (user == null) {
        AppRouter.router.navigateTo(context, AppRoutes.login.route,
            transition: TransitionType.none);
      }
    });
  }

  Stream taskStream;

  DatabaseServices databaseServices = new DatabaseServices();

  TextEditingController taskEdittingControler = new TextEditingController();

  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      this.checkAuthentification();
    });
    databaseServices.getTasks(uId).then((val) {
      taskStream = val;
      setState(() {});
    });

    super.initState();
  }

  Widget taskList() {
    return StreamBuilder(
      stream: taskStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.only(top: 16),
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return TaskTile(
                    isCompleted:
                        snapshot.data.documents[index].data["isCompleted"],
                    task: snapshot.data.documents[index].data["task"],
                    documentId: snapshot.data.documents[index].documentID,
                  );
                })
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'VocabLearn | Todo Test',
      primaryColor: Theme.of(context).primaryColor.value,
    ));

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            width: 600,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: taskEdittingControler,
                        decoration: InputDecoration(hintText: "task"),
                        onChanged: (val) {
                          // taskEdittingControler.text = val;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    taskEdittingControler.text.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              Map<String, dynamic> taskMap = {
                                "task": taskEdittingControler.text,
                                "isCompleted": false
                              };

                              databaseServices.createTask(uId, taskMap);
                              taskEdittingControler.text = "";
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                child: Text("ADD")))
                        : Container()
                  ],
                ),
                taskList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskTile extends StatefulWidget {
  final bool isCompleted;
  final String task;
  final String documentId;
  const TaskTile({Key key, this.isCompleted, this.task, this.documentId})
      : super(key: key);

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GestureDetector(

            onTap: (){

              Map<String,dynamic> taskMap = {
                "task": widget.task,
                "isCompleted" : !widget.isCompleted
              };

              DatabaseServices().updateTask(uId, taskMap, widget.documentId);
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87, width: 1),
                  borderRadius: BorderRadius.circular(30)),
              child: widget.isCompleted
                  ? Icon(
                      Icons.check,
                      color: Colors.green,
                    )
                  : Container(),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            widget.task,
            style: TextStyle(
                color: widget.isCompleted
                    ? Colors.black87
                    : Colors.black87.withOpacity(0.7),
                fontSize: 17,
                decoration: widget.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              DatabaseServices().deleteTask(uId, widget.documentId);
            },
            child: Icon(Icons.close,
                size: 13, color: Colors.black87.withOpacity(0.7)),
          )
        ],
      ),
    );
  }
}
