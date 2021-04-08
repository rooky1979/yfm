import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }

  Future UidQueryData(String queryString) async {
    // debugPrint(FirebaseFirestore.instance.collection('Users')
    //     .where('uid', isGreaterThanOrEqualTo: queryString)
    //     .get().toString());
    return FirebaseFirestore.instance.collection('Users')
        .where('uid', isEqualTo: queryString)
        .get();
  }

  Future UsernameQueryData(String queryString) async {
    // debugPrint(FirebaseFirestore.instance.collection('Users')
    //     .where('uid', isGreaterThanOrEqualTo: queryString)
    //     .get().toString());
    return FirebaseFirestore.instance.collection('Users')
        .where('Username', isEqualTo: queryString)
        .get();
  }
}