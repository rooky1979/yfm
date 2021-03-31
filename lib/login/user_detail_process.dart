import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youth_food_movement/login/placeholder_homepage.dart';
import 'package:youth_food_movement/login/user_detail_page.dart';


class UserDetailProcess extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;

  const UserDetailProcess({Key key, this.snapshot, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final CollectionReference users = FirebaseFirestore.instance.collection('Users');

    // var snapshotData = snapshot.docs[index];
    // var docID = snapshot.docs[index].id;
    //
    // if(_firebaseAuth.currentUser.uid == snapshotData['uid']) {
    //   return PlaceholderHomePage();
    // }
    // return UserDetailPage();

    // return FutureBuilder<DocumentSnapshot> (
    //     future: users.doc('uid').get(),
    //     builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //       if (snapshot.hasError) {
    //         return Text("something went wrong");
    //       }
    //       if(_firebaseAuth.currentUser.uid == snapshot.data) {
    //         return PlaceholderHomePage();
    //       }
    //       return UserDetailPage();
    //     }
    // );

    // QuerySnapshot _query = await users
    //     .where('uid', isEqualTo: _firebaseAuth.currentUser.uid)
    //     .get();
    //
    // //if uid exist in database
    // if(_query.docs.length > 0){
    //   return UserDetailPage();
    // }
    // return PlaceholderHomePage();
  }
}
