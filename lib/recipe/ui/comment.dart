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

  const Comment({Key key, this.snapshot, this.index}) : super(key: key);
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(
                          FontAwesomeIcons.edit,
                          size: 15,
                        ),
                        onPressed: () async {
                          // await showDialog(
                          // context: context,
                          // child: AlertDialog(
                          //   //editible text form
                          //   contentPadding: EdgeInsets.all(10),
                          //   content: Column(
                          //     children: [
                          //       Text('Update Your Comment!'),
                          //       Expanded(
                          //         child: TextField(
                          //           autofocus: true,
                          //           autocorrect: true,
                          //           decoration: InputDecoration(
                          //               labelText: 'Your Name*'),
                          //           controller: nameInputController,
                          //         ),
                          //       ),
                          //       Expanded(
                          //           child: TextField(
                          //         autofocus: true,
                          //         autocorrect: true,
                          //         decoration:
                          //             InputDecoration(labelText: 'Title'),
                          //         controller: titleInputController,
                          //       )),
                          //       Expanded(
                          //           child: TextField(
                          //         autofocus: true,
                          //         autocorrect: true,
                          //         decoration: InputDecoration(
                          //             labelText: 'Description'),
                          //         controller: descriptionInputController,
                          //       )),
                          //     ],
                          //   ),
                          //   actions: [
                          //     FlatButton(
                          //         //cancel button which clears the text fields too
                          //         onPressed: () {
                          //           nameInputController.clear();
                          //           titleInputController.clear();
                          //           descriptionInputController.clear();

                          //           Navigator.pop(context);
                          //         },
                          //         child: Text('Cancel')),
                          //     FlatButton(
                          //         //update button to save the text updates
                          //         onPressed: () {
                          //           if (nameInputController
                          //                   .text.isNotEmpty &&
                          //               titleInputController
                          //                   .text.isNotEmpty &&
                          //               descriptionInputController
                          //                   .text.isNotEmpty) {
                          //             FirebaseFirestore.instance
                          //                 .collection('board')
                          //                 .doc(docID)
                          //                 .update({
                          //               'username':
                          //                   nameInputController.text,
                          //               'title': titleInputController.text,
                          //               'description':
                          //                   descriptionInputController.text,
                          //               'timestamp': new DateTime.now()
                          //             }).then((response) {
                          //               //print(response.id);
                          //               Navigator.pop(context);
                          //               nameInputController.clear();
                          //               titleInputController.clear();
                          //               descriptionInputController.clear();
                          //             }).catchError(
                          //                     (onError) => print(onError));
                          //           }
                          //         },
                          //         child: Text('Update'))
                          //   ],
                          // ));
                        }),
                    _checkUser(docID, widget.index, user)
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

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

      return (IconButton(

          //delete the comment from the database
          icon: Icon(
            FontAwesomeIcons.trashAlt,
            size: 30,
          ),
          onPressed: () async {
            var collectionReference =
                FirebaseFirestore.instance.collection('board');
            collectionReference.doc(docId).delete();
          }));
    } else {
      return (Container());
    }
  }
}
