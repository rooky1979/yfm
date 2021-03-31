import 'dart:developer';

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
    var user = "Temp Name 2";
    var list = [user];
    Color likeColor = Colors.grey;
    //int counter = 100;
    var numLikes = snapshotData['likes'];
    List<String> likedUsers = List.from(snapshotData['likedUsers']);
    bool clickedLike = likedUsers.contains(user);

    //_getCommentImage(docID, widget.index);

    return Column(
      children: [
        Container(
          //height: 190,
          child: Card(
            elevation: 9,
            child: Column(
              children: [
                //tile contents
                ListTile(
                    title: Text(snapshotData['user'] + " - " + dateFormatted,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12.0)),
                    subtitle: Text(snapshotData['description'],
                        style: const TextStyle(
                            fontSize: 17.0, color: Colors.black)),
                    leading: Icon(Icons.account_circle_rounded, size: 50)),
                Row(children: [
                  IconButton(
                      onPressed: () async {
                        setState(() {
                          if (!(likedUsers.contains(user))) {
                            debugPrint("before liked" + clickedLike.toString());
                            likeColor = Colors.blue;
                            numLikes++;
                            FirebaseFirestore.instance
                                .collection('board')
                                .doc(docID)
                                .update({'likes': numLikes});
                            clickedLike = !clickedLike;

                            FirebaseFirestore.instance
                                .collection('board')
                                .doc(docID)
                                .update({
                              'likedUsers': FieldValue.arrayUnion(list)
                            });
                            debugPrint("after liked" + clickedLike.toString());
                          } else {
                            numLikes--;
                            debugPrint(
                                "before dislike" + clickedLike.toString());
                            FirebaseFirestore.instance
                                .collection('board')
                                .doc(docID)
                                .update({'likes': numLikes});
                            clickedLike = !clickedLike;
                            //debugPrint("after change");
                            FirebaseFirestore.instance
                                .collection('board')
                                .doc(docID)
                                .update({
                              'likedUsers': FieldValue.arrayRemove(list)
                            });
                            debugPrint(
                                "after dislike" + clickedLike.toString());
                          }
                        });
                      },
                      icon: Icon(Icons.thumb_up,
                          color: clickedLike ? Colors.blue : Colors.black)
                      //color: Colors.blue,
                      ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10, left: 3, right: 20, bottom: 10),
                    //edit button to edit the comments
                    child: Text(numLikes.toString()),
                  ),
                  _checkUser(docID, widget.index, user, 100, likeColor),
                ]),
                Container(
                  padding: const EdgeInsets.only(
                      top: 10, left: 3, right: 3, bottom: 10),
                  //edit button to edit the comments
                ),
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

  _checkUser(String docId, int id, String user, int counter, Color likeColor) {
    if (widget.snapshot.docs[widget.index]['user'] == user) {
      // if (user == user)

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       // Column(
          //       //   children: [
          //       //     IconButton(
          //       //         onPressed: () async {
          //       //           setState(() {
          //       //             likeColor = Colors.blue;
          //       //             counter++;
          //       //             debugPrint(counter.toString());
          //       //             debugPrint(likeColor.toString());
          //       //           });
          //       //         },
          //       //         icon: Icon(Icons.thumb_up, color: likeColor)
          //       //         //color: Colors.blue,
          //       //         ),
          //       //     Text(counter.toString(),
          //       //         style: const TextStyle(
          //       //             fontSize: 10.0, color: Colors.black))
          //       //   ],
          //       // ),
          //     ],
          //   ),
          // ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(width: 2)),
            child: Row(
              children: [
                IconButton(
                    //delete the comment from the database
                    icon: Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      var collectionReference =
                          FirebaseFirestore.instance.collection('board');
                      collectionReference.doc(docId).delete();
                    }),
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                      //size: 25,
                    ),
                    onPressed: () async {}),
              ],
            ),
          ),
        ],
      );
    } else {
      return (Container());
    }
  }
}
