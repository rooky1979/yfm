import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  //Getting data from cloud firestore database
  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }

  //Search for whether certain uid exist in database
  Future uidQueryData(String queryString) async {
    return FirebaseFirestore.instance.collection('users')
        .where('uid', isEqualTo: queryString)
        .get();
  }

  //search for whether certain username exist in database
  Future usernameQueryData(String queryString) async {
    return FirebaseFirestore.instance.collection('users')
        .where('username', isEqualTo: queryString)
        .get();
  }

  //search for whether certain username exist in database
  Future foodTitleQueryData(String queryString) async {
    return FirebaseFirestore.instance.collection('ingredients')
        .where('title', isGreaterThanOrEqualTo: queryString)
        .where('title', isLessThan: queryString + "\uF7FF")
        .get();
  }
}