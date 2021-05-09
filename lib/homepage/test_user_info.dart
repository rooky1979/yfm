import 'package:youth_food_movement/homepage/user_data.dart';
import 'package:youth_food_movement/comments/comment_form.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TestUserData extends StatefulWidget {
  @override
  _TestUserDataState createState() => _TestUserDataState();
  const TestUserData({Key key, this.snapshot, this.index, this.userID})
      : super(key: key);

  final String userID;
  final QuerySnapshot snapshot;
  final int index;
}

class _TestUserDataState extends State<TestUserData> {
/*
 * This Widget is the main body which encloses the scrollable list of comments, as well as the leave a comment button
 */
  @override
  Widget build(BuildContext context) {
    String userId = widget.userID;
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    debugPrint(_firebaseAuth.currentUser.uid);

    //Creates the snapshot of all comments
    var firestoreDb = FirebaseFirestore.instance
        .collection('users')
        .doc('$userId')
        .snapshots();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          children: [
            StreamBuilder(
                stream: firestoreDb,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return Expanded(
                    child: SizedBox(
                      child:
                          ListView.builder(itemBuilder: (context, int index) {
                        return UserData(
                            snapshot: snapshot.data,
                            index: index,
                            userID: widget.userID);
                      }),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  Future<void> _dialogCall(BuildContext context, String recipeId) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CommentEntryDialog(
            recipeID: recipeId,
          );
        });
  }
}
