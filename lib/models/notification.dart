
import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  final String id;
  final List<String> actions;
  final String content;
  final List<DocumentReference> receivers;
  final DocumentReference sender;
  final String type;
  final bool seen;
  final DateTime createdAt;

  Notification(
    this.id,
    this.actions,
    this.content,
    this.receivers,
    this.sender,
    this.type,
    this.seen,
    this.createdAt
  );

  Map toMap() {
    return {
      "id": this.id,
      "actions": this.actions,
      "content": this.content,
      "receivers": this.receivers,
      "sender": this.sender,
      "type": this.type,
      "seen": this.seen,
      "created_at": this.createdAt
    };
  }
}
