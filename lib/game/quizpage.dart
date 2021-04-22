import 'dart:math';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';
import 'package:vocabulary_learning_app/game/question.dart';
import 'package:vocabulary_learning_app/game/quizbrain.dart';

class QuizPage extends StatefulWidget {
  final String _listId;
  const QuizPage(String listId) : _listId = listId;
  @override
  _QuizPage createState() => _QuizPage(_listId);
}

class _QuizPage extends State<QuizPage> {
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
    Timer(Duration(seconds: 2), () {
      this.checkAuth();
    });

    super.initState();
  }

  var questionNumber = 0;
  bool istrue = true;
  bool visibiliti = false;
  bool acceptclick = true;
  int counttrue = 0;
  int countfalse = 0;
  bool iscomplete = false;

  final String _listId;
  _QuizPage(String listId) : _listId = listId;
  CollectionReference firebaseinstance;
  List<Question> questions = [];
  List<Question> learned = [];
  List<String> answers = [];
  var rand = new Random();
  List<int> rands = [];
  QuizBrain quizBrain;
  bool isloop = false;
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
      label: 'VocabLearn | Practice',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    
    var screenSize = MediaQuery.of(context).size;
    firebaseinstance =
      FirebaseFirestore.instance.collection('lists/${_listId}/words');
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<QuerySnapshot>(
          future: firebaseinstance.get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            if (snapshot.connectionState ==
                    ConnectionState.waiting &&
                isloop == false) {
              return Text("loading");
            }
            if(isloop==false)
            {
              questions.clear();
              for (var document in snapshot.data.docs) {
                questions.add(Question(document.data()["word"], document.data()["definition"]));
              }
              quizBrain = QuizBrain(questions);
              answers.add(quizBrain.getCorrectAnswer(questionNumber));
              var i = 0;
              String value;
              bool loop = false;
              while (i<3) {
                loop = false;
                value = quizBrain.getCorrectAnswer(rand.nextInt(quizBrain.getLength()));
                for (var answer in answers) {
                  if(value==answer)
                  {
                    loop = true;
                    break;
                  }
                }
                if(loop==true) continue;
                answers.add(value);
                i++;
              }
              i = 0;
              int r;
              while(i<4)
              {
                loop = false;
                r = rand.nextInt(4);
                for (var random in rands) {
                  if(r==random)
                  {
                    loop = true;
                    break;
                  }
                }
                if(loop==true) continue;
                rands.add(r);
                i++;
              }
            }
            isloop = true;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.blueGrey[700],
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenSize.width*0.1, vertical: screenSize.height*0.007),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Quiz Game",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('${questionNumber+1}/${quizBrain.getLength()}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text('Questions',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('${counttrue}/${countfalse}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text('True/False',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.home),
                          iconSize: 40,
                          color: Colors.white,
                          onPressed: () {
                            AppRouter.router.navigateTo(
                              context, AppRoutes.homePage.route,
                              transition: TransitionType.none);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                iscomplete?
                  Padding(
                  padding: EdgeInsets.only(right: screenSize.width*0.1, left: screenSize.width*0.1, top: screenSize.height*0.08, bottom: screenSize.height*0.021),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: <Widget>[
                          // Stroked text as border.
                          Text(
                            "You completed Quiz Game!",
                            style: TextStyle(
                              fontSize: 34,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 6
                                ..color = Colors.blue[600],
                            ),
                          ),
                          // Solid text as fill.
                          Text(
                            "You completed Quiz Game!",
                            style: TextStyle(
                              fontSize: 34,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50, bottom: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 400,
                              width: screenSize.width*0.36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue[100],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: screenSize.width*0.36,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.blue,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 25),
                                    child: Text("You progress",
                                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 26, horizontal: 25),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Questions Number:",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(quizBrain.getLength().toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Colors.blue,
                                    height: 2,
                                    width: screenSize.width*0.36,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 26, horizontal: 25),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Correct Number:",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(counttrue.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Colors.blue,
                                    height: 2,
                                    width: screenSize.width*0.36,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 26, horizontal: 25),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Wrong Number:",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(countfalse.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Colors.blue,
                                    height: 2,
                                    width: screenSize.width*0.36,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 26, horizontal: 25),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Excellently",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 28,
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: screenSize.width*0.08,),
                            Container(
                              height: 400,
                              width: screenSize.width*0.36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue[100],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: screenSize.width*0.36,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.blue,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 25),
                                    child: Text("You just learned...",
                                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
                                  ),
                                  Container(
                                    height: 350,
                                    width: screenSize.width*0.36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue[100],
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          for (var i = 0; i < learned.length; i++)
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 25),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(learned[i].question,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(learned[i].answer,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            iscomplete = false;
                            questionNumber = 0;
                            acceptclick = true;
                            counttrue = 0;
                            countfalse = 0;
                            learned.clear();
                            answers.clear();
                            rands.clear();
                            answers.add(quizBrain.getCorrectAnswer(questionNumber));
                            var i = 0;
                            String value;
                            bool loop = false;
                            while (i<3) {
                              loop = false;
                              value = quizBrain.getCorrectAnswer(rand.nextInt(quizBrain.getLength()));
                              for (var answer in answers) {
                                if(value==answer)
                                {
                                  loop = true;
                                  break;
                                }
                              }
                              if(loop==true) continue;
                              answers.add(value);
                              i++;
                            }
                            i = 0;
                            int r;
                            while(i<4)
                            {
                              loop = false;
                              r = rand.nextInt(4);
                              for (var random in rands) {
                                if(r==random)
                                {
                                  loop = true;
                                  break;
                                }
                              }
                              if(loop==true) continue;
                              rands.add(r);
                              i++;
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          child: Text("Play Again",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue[600]),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: Colors.grey[600], style: BorderStyle.solid, width: 1)))
                        ),
                      )
                    ],
                  ),
                )
                : Padding(
                  padding: EdgeInsets.only(right: screenSize.width*0.1, left: screenSize.width*0.1, top: screenSize.height*0.078, bottom: screenSize.height*0.021),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SliderTheme(
                        child: Slider(
                          value: (questionNumber + 1).toDouble(),
                          max: quizBrain.getLength().toDouble(),
                          min: 0,
                          activeColor: Colors.yellow,
                          inactiveColor: Colors.grey[200],
                          onChanged: (double value) {},
                        ),
                        data: SliderThemeData(
                          trackHeight: 28,
                          thumbColor: Colors.transparent,
                          overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
                          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15,elevation: 0, disabledThumbRadius: 15, pressedElevation: 0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenSize.height*0.064),
                        child: Text("choose the correct answer from the following translation words",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 28,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenSize.height*0.058, bottom: screenSize.height*0.031),
                        child: Text(quizBrain.getQuestion(questionNumber),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      buildwrap(screenSize),
                    ],
                  ),
                ),
                SizedBox(height: screenSize.height*0.112,),
                Visibility(
                  maintainAnimation: true,
                  maintainState: true,
                  maintainSize: true,
                  visible: visibiliti,
                  child: Container(
                    height: screenSize.height*0.182,
                    color: istrue? Colors.lightGreen[200] : Colors.red[100],
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenSize.width*0.15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(istrue? Icons.check : Icons.close,
                              color: istrue?Colors.lightGreen:Colors.red,
                              size: 32,
                            ),
                          ),
                          istrue? Text("Excellently",
                            style: TextStyle(fontSize: 26, color: Colors.lightGreen, fontWeight: FontWeight.bold),
                          )
                          : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Correct answer:",
                              style: TextStyle(fontSize: 26, color: Colors.red, fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              Text(quizBrain.getCorrectAnswer(questionNumber),
                              style: TextStyle(fontSize: 18, color: Colors.red,),)
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                visibiliti = false;
                                questionNumber += 1;
                                if(questionNumber==quizBrain.getLength())
                                {
                                  iscomplete = true;
                                  questionNumber -= 1;
                                }
                                else
                                {
                                  acceptclick = true;
                                  answers.clear();
                                  rands.clear();
                                  answers.add(quizBrain.getCorrectAnswer(questionNumber));
                                  var i = 0;
                                  String value;
                                  bool loop = false;
                                  while (i<3) {
                                    loop = false;
                                    value = quizBrain.getCorrectAnswer(rand.nextInt(quizBrain.getLength()));
                                    for (var answer in answers) {
                                      if(value==answer)
                                      {
                                        loop = true;
                                        break;
                                      }
                                    }
                                    if(loop==true) continue;
                                    answers.add(value);
                                    i++;
                                  }
                                  i = 0;
                                  int r;
                                  while(i<4)
                                  {
                                    loop = false;
                                    r = rand.nextInt(4);
                                    for (var random in rands) {
                                      if(r==random)
                                      {
                                        loop = true;
                                        break;
                                      }
                                    }
                                    if(loop==true) continue;
                                    rands.add(r);
                                    i++;
                                  }
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Text("Continue",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(istrue? Colors.lightGreen : Colors.red),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        side: BorderSide(
                                            color: Colors.grey[600], style: BorderStyle.solid, width: 1)))
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildwrap(Size screenSize)
  {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: screenSize.width*0.022,
      runSpacing: screenSize.height*0.012,
      children: [
        Container(
          width: screenSize.width*0.3,
          height: screenSize.height*0.087,
          margin: EdgeInsets.only(top: screenSize.height*0.038),
          child: acceptclick?
          TextButton(
            onPressed: () {
              setState(() {
                acceptclick = false;
                if(quizBrain.getCorrectAnswer(questionNumber)==answers[rands[0]])
                {
                  istrue = true;
                  visibiliti = true;
                  counttrue += 1;
                  learned.add(Question(quizBrain.getQuestion(questionNumber), quizBrain.getCorrectAnswer(questionNumber)));
                }
                else
                {
                  istrue = false;
                  visibiliti = true;
                  countfalse += 1;
                }
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: screenSize.width*0.015,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.grey[400])
                  ),
                  child: Text("A",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width*0.035,),
                Text(
                  answers[rands[0]],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 10)),
              backgroundColor:
                MaterialStateProperty.all<Color>(Colors.white),
              shadowColor: MaterialStateProperty.all<Color>(Colors.grey[400]),
              elevation: MaterialStateProperty.all<double>(4),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.grey[400], style: BorderStyle.solid, width: 2)))),
          )
          :TextButton(
            onPressed: null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: screenSize.width*0.015,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.grey[400])
                  ),
                  child: Text("A",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width*0.035,),
                Text(
                  answers[rands[0]],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 10)),
              backgroundColor:
                MaterialStateProperty.all<Color>(Colors.white),
              shadowColor: MaterialStateProperty.all<Color>(Colors.grey[400]),
              elevation: MaterialStateProperty.all<double>(4),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.grey[400], style: BorderStyle.solid, width: 2)))),
          ),
        ),
        Container(
          width: screenSize.width*0.3,
          height: screenSize.height*0.087,
          margin: EdgeInsets.only(top: screenSize.height*0.038),
          child: acceptclick?
          TextButton(
            onPressed: () {
              setState(() {
                acceptclick = false;
                if(quizBrain.getCorrectAnswer(questionNumber)==answers[rands[1]])
                {
                  istrue = true;
                  visibiliti = true;
                  counttrue += 1;
                  learned.add(Question(quizBrain.getQuestion(questionNumber), quizBrain.getCorrectAnswer(questionNumber)));
                }
                else
                {
                  istrue = false;
                  visibiliti = true;
                  countfalse += 1;
                }
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: screenSize.width*0.015,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.grey[400])
                  ),
                  child: Text("B",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width*0.035,),
                Text(
                  answers[rands[1]],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 10)),
              backgroundColor:
                MaterialStateProperty.all<Color>(Colors.white),
              shadowColor: MaterialStateProperty.all<Color>(Colors.grey[400]),
              elevation: MaterialStateProperty.all<double>(4),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.grey[400], style: BorderStyle.solid, width: 2)))),
          )
          :TextButton(
            onPressed: null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: screenSize.width*0.015,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.grey[400])
                  ),
                  child: Text("B",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width*0.035,),
                Text(
                  answers[rands[1]],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 10)),
              backgroundColor:
                MaterialStateProperty.all<Color>(Colors.white),
              shadowColor: MaterialStateProperty.all<Color>(Colors.grey[400]),
              elevation: MaterialStateProperty.all<double>(4),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.grey[400], style: BorderStyle.solid, width: 2)))),
          ),
        ),
        Container(
          width: screenSize.width*0.3,
          height: screenSize.height*0.087,
          margin: EdgeInsets.only(top: screenSize.height*0.038),
          child: acceptclick?
          TextButton(
            onPressed: () {
              setState(() {
                acceptclick = false;
                if(quizBrain.getCorrectAnswer(questionNumber)==answers[rands[2]])
                {
                  istrue = true;
                  visibiliti = true;
                  counttrue += 1;
                  learned.add(Question(quizBrain.getQuestion(questionNumber), quizBrain.getCorrectAnswer(questionNumber)));
                }
                else
                {
                  istrue = false;
                  visibiliti = true;
                  countfalse += 1;
                }
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: screenSize.width*0.015,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.grey[400])
                  ),
                  child: Text("C",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width*0.035,),
                Text(
                  answers[rands[2]],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 10)),
              backgroundColor:
                MaterialStateProperty.all<Color>(Colors.white),
              shadowColor: MaterialStateProperty.all<Color>(Colors.grey[400]),
              elevation: MaterialStateProperty.all<double>(4),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.grey[400], style: BorderStyle.solid, width: 2)))),
          )
          : TextButton(
            onPressed: null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: screenSize.width*0.015,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.grey[400])
                  ),
                  child: Text("C",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width*0.035,),
                Text(
                  answers[rands[2]],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 10)),
              backgroundColor:
                MaterialStateProperty.all<Color>(Colors.white),
              shadowColor: MaterialStateProperty.all<Color>(Colors.grey[400]),
              elevation: MaterialStateProperty.all<double>(4),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.grey[400], style: BorderStyle.solid, width: 2)))),
          ),
        ),
        Container(
          width: screenSize.width*0.3,
          height: screenSize.height*0.087,
          margin: EdgeInsets.only(top: screenSize.height*0.038),
          child: acceptclick?
          TextButton(
            onPressed: () {
              setState(() {
                acceptclick = false;
                if(quizBrain.getCorrectAnswer(questionNumber)==answers[rands[3]])
                {
                  istrue = true;
                  visibiliti = true;
                  counttrue += 1;
                  learned.add(Question(quizBrain.getQuestion(questionNumber), quizBrain.getCorrectAnswer(questionNumber)));
                }
                else
                {
                  istrue = false;
                  visibiliti = true;
                  countfalse += 1;
                }
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: screenSize.width*0.015,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.grey[400])
                  ),
                  child: Text("D",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width*0.035,),
                Text(
                  answers[rands[3]],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 10)),
              backgroundColor:
                MaterialStateProperty.all<Color>(Colors.white),
              shadowColor: MaterialStateProperty.all<Color>(Colors.grey[400]),
              elevation: MaterialStateProperty.all<double>(4),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.grey[400], style: BorderStyle.solid, width: 2)))),
          )
          : TextButton(
            onPressed: null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: screenSize.width*0.015,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.grey[400])
                  ),
                  child: Text("D",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width*0.035,),
                Text(
                  answers[rands[3]],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 10)),
              backgroundColor:
                MaterialStateProperty.all<Color>(Colors.white),
              shadowColor: MaterialStateProperty.all<Color>(Colors.grey[400]),
              elevation: MaterialStateProperty.all<double>(4),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.grey[400], style: BorderStyle.solid, width: 2)))),
          ),
        )
      ],
    );
  }
}
