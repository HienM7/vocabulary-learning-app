import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPage createState() => _QuizPage();
}

class _QuizPage extends State<QuizPage> {
  var sliderValue = 12;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.blueGrey[700],
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width*0.1, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Name List',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('12/50',
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
                        Text('10/1',
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
                      onPressed: (){
                        AppRouter.router.navigateTo(context, AppRoutes.homePage.route);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: screenSize.width*0.1, left: screenSize.width*0.1, top: 60, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SliderTheme(
                    child: Slider(
                      value: sliderValue.toDouble(),
                      max: 50,
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
                    padding: EdgeInsets.only(top: 50),
                    child: Text("choose the correct answer from the following translation words",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50, bottom: 30),
                    child: Text("Dong vat",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: screenSize.width*0.022,
                    runSpacing: 10,
                    children: [
                      Container(
                        width: screenSize.width*0.3,
                        height: 65,
                        margin: EdgeInsets.only(top: 30),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              
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
                                "Animal",
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
                        )),
                      Container(
                        width: screenSize.width*0.3,
                        height: 65,
                        margin: EdgeInsets.only(top: 30),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              
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
                                "Friendly",
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
                        )),
                      Container(
                        width: screenSize.width*0.3,
                        height: 65,
                        margin: EdgeInsets.only(top: 30),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              
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
                                "Cater",
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
                        )),
                      Container(
                        width: screenSize.width*0.3,
                        height: 65,
                        margin: EdgeInsets.only(top: 30),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              
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
                                "Lion",
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
                        ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
