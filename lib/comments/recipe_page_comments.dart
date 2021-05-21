import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youth_food_movement/recipe/ui/recipe_controls_page.dart';
import 'package:youth_food_movement/comments/comment.dart';
import 'package:youth_food_movement/comments/comment_form.dart';

class CommentBoard extends StatefulWidget {
  @override
  _CommentBoardState createState() => _CommentBoardState();
  const CommentBoard({Key key, this.snapshot, this.index, this.recipeID})
      : super(key: key);

  final String recipeID;
  final QuerySnapshot snapshot;
  final int index;
}

// This Widget is the main body which encloses the scrollable list of comments, as well as the leave a comment button

class _CommentBoardState extends State<CommentBoard> {
  @override
  Widget build(BuildContext context) {
    String recipeId = widget.recipeID;
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    debugPrint(_firebaseAuth.currentUser.uid);

    //Creates the snapshot of all comments in descending
    var firestoreDb = FirebaseFirestore.instance
        .collection('recipe')
        .doc('$recipeId')
        .collection('comments')
        .orderBy('likes', descending: true)
        .snapshots();

    return Scaffold(
      backgroundColor: new Color(0xFFf0f1eb),
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
                    //List view generates a list of comment widgets, of length determineed by number of docs.
                    child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, int index) {
                        return Comment(
                            snapshot: snapshot.data,
                            index: index,
                            recipeID: widget.recipeID);
                      },
                    ),
                  ),
                );
              },
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 2),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF4ca5b5),
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: TextButton(
                        onPressed: () async {
                          await _dialogCall(context, widget.recipeID);
                        },
                        child: Text(
                          "COMMENT!",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // This Method creates the comment entry form
  // It takes the recipeID so the Comment is saved to the correct recipe

  Future<void> _dialogCall(BuildContext context, String recipeId) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CommentEntryDialog(
          recipeID: recipeId,
        );
      },
    );
  }
}
