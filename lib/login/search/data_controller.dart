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
  Future UidQueryData(String queryString) async {
    return FirebaseFirestore.instance.collection('Users')
        .where('uid', isEqualTo: queryString)
        .get();
  }

  //search for whether certain username exist in database
  Future UsernameQueryData(String queryString) async {
    return FirebaseFirestore.instance.collection('Users')
        .where('Username', isEqualTo: queryString)
        .get();
  }
}