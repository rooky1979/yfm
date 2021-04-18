import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

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
    //CollectionReference imgRef;
//to convert the timestamp into readble format
    var timeToDate = new DateTime.fromMillisecondsSinceEpoch(
        widget.snapshot.docs[widget.index]['timestamp'].seconds * 1000);
//format the timestamp into a readable date
    var dateFormatted = new DateFormat('EEE d MMM, y').format(timeToDate);

    var snapshotData = widget.snapshot.docs[widget.index];
    var docID = widget.snapshot.docs[widget.index].id;
    var user = "Temp Name";

    //_getCommentImage(docID, widget.index);

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
                      //Image.network(src)
                    ],
                  ),
                ),
                Row(
                  //edit button to edit the comments
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

  // ignore: unused_element
  Future _getCommentImage(String docId, int id) async {
    //FirebaseFirestore.instance.collection('board');

    //instantiate storage bucket
    //create a futurebuilder which calls this method as a future
    //return a container with a circular progresss indicator child
    if (widget.snapshot.docs[widget.index]['imgAttached'] == "true") {
      final ref = FirebaseStorage.instance.ref().child('images/' + docId);
      var url = await ref.getDownloadURL();
      return (url);
    }
  }

  _checkUser(String docId, int id, String user) {
    if (widget.snapshot.docs[widget.index]['user'] == user) {
      // if (user == user)
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                //delete the comment from the database
                icon: Icon(
                  FontAwesomeIcons.trashAlt,
                  size: 25,
                ),
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
      return (Container());
    }
  }
}
