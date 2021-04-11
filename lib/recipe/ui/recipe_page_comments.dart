//import 'dart:io';
import 'package:youth_food_movement/recipe/ui/comment.dart';
import 'package:youth_food_movement/recipe/ui/recipe_controls_page.dart';
import 'package:youth_food_movement/recipe/ui/comment_form.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:youth_food_movement/comments/comment.dart';
import 'package:youth_food_movement/recipe/ui/recipe_controls_page.dart';
import 'package:youth_food_movement/comments/comment_form.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:image_picker/image_picker.dart';

class CommentBoard extends StatefulWidget {
  @override
  _CommentBoardState createState() => _CommentBoardState();

  final String recipeID;
  final QuerySnapshot snapshot;
  final int index;

  const CommentBoard({Key key, this.snapshot, this.index, this.recipeID})
      : super(key: key);

}

class _CommentBoardState extends State<CommentBoard> {
//   database connection to the board firebase

  var firestoreDb = FirebaseFirestore.instance
      .collection('recipe')
      .doc('7jKfiM0kZugLdDFJ1XAy')
      .collection('comments')
      .snapshots();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //the body has the whole screen being used
        body: Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          RecipeThumbnail(),
          RecipeButtons(),
          StreamBuilder(
              stream: firestoreDb,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return Expanded(
                  child: SizedBox(
                    //height: 120,
                    child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, int index) {
                          return Comment(
                              snapshot: snapshot.data,
                              index: index,
                              recipeID: '7jKfiM0kZugLdDFJ1XAy');

                        }),
                  ),
                );
              }),
          Container(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            // decoration: BoxDecoration(
            //     border: Border.all(width: 1),
            //     borderRadius: BorderRadius.circular(2)),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: TextButton(
                        onPressed: () async {
                          await _dialogCall(context);
                        },
                        child: Text("Leave a comment!",
                            style: TextStyle(
                                fontSize: 18, color: Colors.black87))),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  Future<void> _dialogCall(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CommentEntryDialog();
        });
  }
}
