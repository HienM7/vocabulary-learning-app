import 'package:flutter/material.dart';
import 'package:vocabulary_learning_app/Home/widgets/info_text.dart';
import 'package:vocabulary_learning_app/Home/widgets/bottom_bar_colum.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('LEARNING',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15,),
                  InfoText(
                    type: 'Email',
                    text: 'Learning@gmail.com',
                  ),
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
    );
  }
}