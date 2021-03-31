import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }

  Future QueryData(String queryString) async {
    return FirebaseFirestore.instance.collection('Users')
        .where('uid', isGreaterThanOrEqualTo: queryString)
        .get();
  }
}