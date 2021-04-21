import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';

class NotifCard extends StatefulWidget {
  final DocumentSnapshot _notif;  
  NotifCard(DocumentSnapshot notif) : _notif = notif;

  @override
  _NotifCardState createState() => _NotifCardState(
    _notif,
    _notif.data()["actions"].forEach((act) => false)
  );
}

class _NotifCardState extends State<NotifCard> {
  List<bool> _buttonPressed = [];
  final DocumentSnapshot _notif;
  
  _NotifCardState(DocumentSnapshot notif, List<bool> btnPressed)
    : _notif = notif, _buttonPressed = btnPressed;

  @override
  Widget build(BuildContext context) {
    
    var screenSize = MediaQuery.of(context).size;
    return Card(
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
                  _notif.data()["type"] == "invite" ?
                  "Collaboration Invitation" :
                  _notif.data()["type"] == "update" ?
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
                _notif
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
                _notif.data()["content"],
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
              
              if (!_notif.data()["seen"])
              for (var actionText in _notif.data()["actions"])
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: TextButton(
                  child: Text(
                    " " + actionText + " ",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                      MaterialStateProperty
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
    );
  }
}
