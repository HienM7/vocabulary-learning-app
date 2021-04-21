import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  updateUserInfo(String userId, Map infoUserMap) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(infoUserMap);
  }

  getUserInfo(String id) async{
   return await FirebaseFirestore.instance
        .collection("profiles")
        .doc(id)
        .snapshots();
  }

  updateCountryInfo(String userId, Map countryInfo) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(countryInfo);
  }

  updateList(String userId, Map listMap, String listId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("list")
        .doc(listId)
        .set(listMap);
  }

  createList(String userId, Map listMap) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("list")
        .add(listMap);
  }

  getList(String userId) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("list")
        .snapshots();
  }

  deleteList(String userId, String listId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("list")
        .doc(listId)
        .delete()
        .catchError((e) {
      print(e.toString());
    });
  }

  updateWord(String userId, String listId, String wordId, Map wordMap) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("list")
        .doc(listId)
        .collection("word")
        .doc(wordId)
        .set(wordMap);
  }

  createWord(String userId, String listId, Map wordMap) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("list")
        .doc(listId)
        .collection("word")
        .add(wordMap);
  }

  getWord(String userId, String listId) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("list")
        .doc(listId)
        .collection("word")
        .snapshots();
  }

  deleteWord(String userId, String listId, String wordId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("list")
        .doc(listId)
        .collection("word")
        .doc(wordId)
        .delete()
        .catchError((e) {
      print(e.toString());
    });
  }

  // ------------- Test ----------------
  updateTask(String userId, Map taskMap, String documentId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("tasks")
        .doc(documentId)
        .set(taskMap);
  }

  createTask(String userId, Map taskMap) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("tasks")
        .add(taskMap);
  }

  getTasks(String userId) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("tasks")
        .snapshots();
  }

  deleteTask(String userId, String documentId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("tasks")
        .doc(documentId)
        .delete()
        .catchError((e) {
      print(e.toString());
    });
  }
  // ------------- Test ----------------
}
