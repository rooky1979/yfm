import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

String docID;

class DataController extends GetxController {
  //Connect to database and getting data from cloud firestore database
  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }

  //Search for whether certain uid exists in database in "users" collection
  Future uidQueryData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: queryString)
        .get();
  }

  //Search for whether certain email exists in database in "users" collection
  Future emailQueryData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: queryString)
        .get();
  }

  //search for whether certain username exists in database in "users" collection
  Future usernameQueryData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: queryString)
        .get();
  }

  //search for whether certain food title exists in database in subcollection "ingredient"
  // inside document inside "recipe"
  //Not working
  Future foodTitleQueryData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('recipe')
        .doc('$docID')
        .collection('ingredients')
        .where('title', isGreaterThanOrEqualTo: queryString) //starting point
        .where('title', isLessThan: queryString + "\uF7FF") //end point with last unicode
        .get();
  }
}
