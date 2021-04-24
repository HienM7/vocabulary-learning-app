import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class InfoText extends StatelessWidget {
  final String type;
  final String text;

  InfoText({this.type, this.text});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Row(
      children: [
        screenSize.width > 800 ?
        Text(
          '$type: ',
          style: TextStyle(
            color: Colors.blueGrey[300],
            fontSize: 16,
          ),
        )
        : Text(
          '$type: ',
          style: TextStyle(
            color: Colors.blueGrey[300],
            fontSize: 10,
          ),
        ),
        screenSize.width > 800 ?
        Text(
          text,
          style: TextStyle(
            color: Colors.blueGrey[100],
            fontSize: 16,
          ),
        )
        : Text(
          text,
          style: TextStyle(
            color: Colors.blueGrey[100],
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}