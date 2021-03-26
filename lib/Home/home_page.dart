import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabulary_learning_app/Home/widgets/info_text.dart';
import 'package:vocabulary_learning_app/Home/widgets/bottom_bar_colum.dart';

class HomePageUser extends StatefulWidget {
  @override
  _HomePageStateUser createState() => _HomePageStateUser();
}

class _HomePageStateUser extends State<HomePageUser> {
  List _isHovering = [false, false, false];
  CollectionReference firebaseinstance = Firestore.instance.collection('list');
  List<Map<dynamic, dynamic>> lists = [];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: Colors.blueGrey[700],
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 180, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(' LEARNING',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
                InkWell(
                  onTap: () {},
                  onHover: (value) {
                    setState(() {
                      _isHovering[0] = value;
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.home,
                        size: 25,
                        color: _isHovering[0]
                        ? Colors.yellow
                        : Colors.white,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Home',
                            style: TextStyle(
                              color: _isHovering[0]
                                  ? Colors.yellow
                                  : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 3),
                          // For showing an underline on hover
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[0],
                            child: Container(
                              height: 3,
                              width: 56,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ]
                  ),
                ),
                InkWell(
                  onTap: () {},
                  onHover: (value) {
                    setState(() {
                      _isHovering[1] = value;
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.my_library_books_outlined,
                        size: 25,
                        color: _isHovering[1]
                        ? Colors.yellow
                        : Colors.white,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'My List',
                            style: TextStyle(
                              color: _isHovering[1]
                                  ? Colors.yellow
                                  : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 3),
                          // For showing an underline on hover
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[1],
                            child: Container(
                              height: 3,
                              width: 66,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ),
                IconButton(
                  icon: Icon(Icons.account_circle),
                  iconSize: 40,
                  color: Colors.yellow[600],
                  onPressed: (){},
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 180, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Home',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width: 500),
                      TextButton(
                        onPressed: (){},
                        child: Text('Create a list', style: TextStyle(color: Colors.white, fontSize: 18),),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 25, vertical: 15)),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent[700]),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: Colors.greenAccent[700])
                            )
                          )
                        ),
                      ),
                      SizedBox(width: 100),
                      
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
                        SizedBox(width: 20,),
                        Text(
                          'List Public',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 34,
                          ),
                        )
                      ],
                    )
                  ),
                  // card list publish
                  FutureBuilder(
                    future: firebaseinstance.getDocuments(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if(snapshot.hasData)
                      {
                        if(snapshot.data != null)
                        {
                          lists.clear();
                          for (var document in snapshot.data.documents) {
                            lists.add(document.data);
                          }
                          return new ListView.builder(
                            shrinkWrap: true,
                            itemCount: lists.length,
                            itemBuilder: (BuildContext context, int index){
                              return Card(
                                borderOnForeground: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Colors.grey[200],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: Container(
                                        height: 200,
                                        width: 360,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(lists[index]['url_image']),
                                            fit: BoxFit.cover,
                                          )
                                        )
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      margin: EdgeInsets.only(top: 15, bottom: 10, left: 15),
                                      child: Text(
                                        lists[index]['name'],
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        else return CircularProgressIndicator();
                      }
                      else return CircularProgressIndicator();
                    },
                  ),
                ],
              )
            ),
            // HomePage footer
            Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              color: Colors.blueGrey[900],
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BottomBarColumn(
                        heading: 'ABOUT',
                        s1: 'Contact Us',
                        s2: 'About Us',
                        s3: 'Careers',
                      ),
                      BottomBarColumn(
                        heading: 'HELP',
                        s1: 'Payment',
                        s2: 'Cancellation',
                        s3: 'FAQ',
                      ),
                      BottomBarColumn(
                        heading: 'SOCIAL',
                        s1: 'Twitter',
                        s2: 'Facebook',
                        s3: 'YouTube',
                      ),
                      Container(
                        color: Colors.blueGrey,
                        width: 2,
                        height: 150,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoText(
                            type: 'Email',
                            text: 'explore@gmail.com',
                          ),
                          SizedBox(height: 5),
                          InfoText(
                            type: 'Address',
                            text: '128, Trymore Road, Delft, MN - 56124',
                          )
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.blueGrey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Copyright © 2020 | EXPLORE',
                    style: TextStyle(
                      color: Colors.blueGrey[300],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}