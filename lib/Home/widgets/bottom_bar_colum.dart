import 'package:flutter/material.dart';

class BottomBarColumn extends StatelessWidget {
  final String heading;
  final String s1;
  final String s2;
  final String s3;

  BottomBarColumn({
    this.heading,
    this.s1,
    this.s2,
    this.s3,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: screenSize.width*0.03),
      child: screenSize.width > 800 ?
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
              color: Colors.blueGrey[300],
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            s1,
            style: TextStyle(
              color: Colors.blueGrey[100],
              fontSize: 14,
            ),
          ),
          SizedBox(height: 5),
          Text(
            s2,
            style: TextStyle(
              color: Colors.blueGrey[100],
              fontSize: 14,
            ),
          ),
          SizedBox(height: 5),
          Text(
            s3,
            style: TextStyle(
              color: Colors.blueGrey[100],
              fontSize: 14,
            ),
          ),
        ],
      )
      : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
              color: Colors.blueGrey[300],
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            s1,
            style: TextStyle(
              color: Colors.blueGrey[100],
              fontSize: 10,
            ),
          ),
          SizedBox(height: 4),
          Text(
            s2,
            style: TextStyle(
              color: Colors.blueGrey[100],
              fontSize: 10,
            ),
          ),
          SizedBox(height: 4),
          Text(
            s3,
            style: TextStyle(
              color: Colors.blueGrey[100],
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}