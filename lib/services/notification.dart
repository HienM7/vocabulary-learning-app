import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabulary_learning_app/models/notification.dart';

class NotifService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<DocumentReference> create(Map notifData) async {
    return db
      .collection("notifs")
      .add(notifData);
  }

  Future<QuerySnapshot> fetchAll(DocumentReference receiver) async {
    return db
      .collection("notifs")
      .where("receivers", arrayContains: receiver)
      .orderBy('created_at', descending: true)
      .get();
  }

  Future<QuerySnapshot> fetchBatch(
    DocumentReference receiver,
    List<DocumentSnapshot> shownDocs,
    int batchSize) async {

    if (shownDocs.isEmpty)
      return db
      .collection("notifs")
      .where("receivers", arrayContains: receiver)
      .orderBy('created_at', descending: true)
      .limit(batchSize)
      .get();
    
    else
      return db
      .collection("notifs")
      .where("receivers", arrayContains: receiver)
      .orderBy('created_at', descending: true)
      .startAfter(
        [shownDocs[shownDocs.length-1].data()["created_at"]]
      )
      .limit(batchSize)
      .get();
  }

  // not used
  update(Notification notif, Map notifData) {
    db
      .collection("notifs")
      .doc(notif.id)
      .set(notifData);
  }

  delete(Notification notif) {
    db
      .collection("notifs")
      .doc(notif.id)
      .delete()
      .catchError((e) {
        print(e.toString());
      });
  }

  Future<bool> checkAnyUnseen(DocumentReference user) {
    return db
      .collection("notifs")
      .where("seen", isEqualTo: false)
      .where("receivers", arrayContains: user)
      .get()
      .then((snapshot) => snapshot.size > 0);
  }
}
