import 'package:flutter/material.dart';
import 'package:vocabulary_learning_app/Home/widgets/info_text.dart';
import 'package:vocabulary_learning_app/Home/widgets/bottom_bar_colum.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(screenSize.width*0.025),
      margin: EdgeInsets.fromLTRB(0, screenSize.width*0.025, 0, 0),
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
                s3: '',
              ),
              BottomBarColumn(
                heading: 'HELP',
                s1: 'Features',
                s2: 'FAQ',
                s3: '',
              ),
              BottomBarColumn(
                heading: 'SOCIAL',
                s1: 'Facebook',
                s2: 'YouTube',
                s3: ''
              ),
              screenSize.width > 800 ?
              Container(
                color: Colors.blueGrey,
                width: 2,
                height: 150,
              ):
              Container(
                color: Colors.blueGrey,
                width: 2,
                height: 75,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  screenSize.width > 800 ?
                  Text('VOCABLEARN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  : Text('VOCABLEARN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenSize.width*0.01),
                  InfoText(
                    type: 'Email',
                    text: 'contact@vocablearn.com',
                  ),
                  SizedBox(height: 5),
                  InfoText(
                    type: 'Address',
                    text: '999 Nguyen Luong Bang, Da Nang',
                  )
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.blueGrey,
          ),
          SizedBox(height: screenSize.width*0.015),
          Text(
            'Copyright © 2020 | VOCABLEARN',
            style: TextStyle(
              color: Colors.blueGrey[300],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
