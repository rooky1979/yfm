import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

/**
 * This Comment.dart file generates a single card for a comment as a list tile.
 * This class is called as many times as necesarry by the recipe_page_comments.dart file.
 * It is constructed with index, snapshot, and recipeID which allow it to know which subtable document it belongs to.
 */
class Comment extends StatefulWidget {
  @override
  _CommentState createState() => _CommentState();
  final QuerySnapshot snapshot;
  final int index;
  final String recipeID;

  const Comment({Key key, this.snapshot, this.index, this.recipeID})
      : super(key: key);
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    //to convert the timestamp into readble format
    var timeToDate = new DateTime.fromMillisecondsSinceEpoch(
        widget.snapshot.docs[widget.index]['timestamp'].seconds * 1000);

    //format the timestamp into a readable date
    var dateFormatted = new DateFormat('EEE d MMM, y').format(timeToDate);

    //Assigns the data from the constructor
    var snapshotData = widget.snapshot.docs[widget.index];
    var docID = widget.snapshot.docs[widget.index].id;
    var user = "Temp Name";

    //This is the main code which generates the comment card
    return Column(
      children: [
        Container(
          height: 190,
          child: Card(
            elevation: 9,
            child: Column(
              children: [
                //tile contents
                ListTile(
                    title: Text(snapshotData['user']),
                    subtitle: Text(snapshotData['description']),
                    leading: Icon(Icons.account_circle_rounded, size: 50)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('User: ${snapshotData['user']} '),
                      Text(dateFormatted),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [_checkUser(docID, widget.index, user)],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  /*
   * This GetCommentImage method checks if the comment has an image attached to it. 
   * If an image is attached it returns the image from the Firebase storage, within the folder 'images/'
   * Each image is named by the ID of the comment, making this a 1-1 relationship
   */
  Future _getCommentImage(String docId) async {
    if (widget.snapshot.docs[widget.index]['imgAttached'] == "true") {
      final ref = FirebaseStorage.instance.ref().child('images/' + docId);
      var url = await ref.getDownloadURL();
      return (url);
    }
  }

/*
 * This check user method compares the current session user to the user who has made the comment. 
 * If the user has made the comment the delete button is returned to the comment card, and when pressed deletes from the database
 */
  _checkUser(String docId, int id, String user) {
    //Checks whether users match
    if (widget.snapshot.docs[widget.index]['user'] == user) {
      //Returns container with delete button if true
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.trashAlt,
                  size: 25,
                ),
                //Delete comment from Database
                onPressed: () async {
                  var collectionReference =
                      FirebaseFirestore.instance.collection('board');
                  collectionReference.doc(docId).delete();
                }),
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.edit,
                  size: 25,
                ),
                onPressed: () async {}),
          ],
        ),
      );
    } else {
      //Returns empty container effectively disabling the delete button
      return (Container());
    }
  }
}
