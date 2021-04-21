import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabulary_learning_app/models/notification.dart';

class NotifService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<DocumentReference> create(Map notifData) async {
    return db
      .collection("notifs")
      .add(notifData);
  }

  Future<QuerySnapshot> fetchAll(String recvId) async {
    return db
      .collection("notifs")
      .where("receiver_ids", arrayContains: recvId)
      .orderBy('created_at', descending: true)
      .get();
  }

  Future<QuerySnapshot> fetchBatch(
    String recvId,
    List<DocumentSnapshot> shownDocs,
    int batchSize) async {

    if (shownDocs.isEmpty)
      return db
      .collection("notifs")
      .where("receiver_ids", arrayContains: recvId)
      .orderBy('created_at', descending: true)
      .limit(batchSize)
      .get();
    
    else
      return db
      .collection("notifs")
      .where("receiver_ids", arrayContains: recvId)
      .orderBy('created_at', descending: true)
      .startAfter(
        [shownDocs[shownDocs.length-1].data()["created_at"]]
      )
      .limit(batchSize)
      .get();
  }

  update(DocumentSnapshot notif, Map<String, dynamic> notifData) {
    db
      .collection("notifs")
      .doc(notif.id)
      .update(notifData);
  }

  delete(DocumentSnapshot notif) {
    db
      .collection("notifs")
      .doc(notif.id)
      .delete()
      .catchError((e) {
        print(e.toString());
      });
  }

  Future<bool> checkAnyUnseen(String userId) {
    return db
      .collection("notifs")
      .where("seen", isEqualTo: false)
      .where("receiver_ids", arrayContains: userId)
      .get()
      .then((snapshot) => snapshot.size > 0);
  }
}
