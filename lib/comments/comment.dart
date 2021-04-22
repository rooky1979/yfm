import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
//import 'package:youth_food_movement/recipe/ui/comment_update_form.dart';

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
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: 'gs://youth-food-movement.appspot.com');
  Widget build(BuildContext context) {
    //CollectionReference imgRef;
//to convert the timestamp into readble format
    var timeToDate = new DateTime.fromMillisecondsSinceEpoch(
        widget.snapshot.docs[widget.index]['timestamp'].seconds * 1000);
//format the timestamp into a readable date
    var dateFormatted = new DateFormat('EEE d MMM, y').format(timeToDate);
    var snapshotData = widget.snapshot.docs[widget.index];
    var docID = widget.snapshot.docs[widget.index].id;
    var user = "temp2";
    var list = [user];
    Color likeColor = Colors.grey;
    //int counter = 100;
    var numLikes = snapshotData['likes'];
    List<String> likedUsers = List.from(snapshotData['likedUsers']);
    bool clickedLike = likedUsers.contains(user);

    //TextEditingController descriptionInputController =
    TextEditingController(text: snapshotData['description']);

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
                FutureBuilder(
                    future: _getImageURL(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        //return the image and make it cover the container
                        return GestureDetector(
                          child: Image.network(
                            snapshot.data,
                            fit: BoxFit.cover,
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return GestureDetector(
                                child: Center(
                                  child: Image.network(
                                    snapshot.data,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                onTap: () => Navigator.pop(context),
                              );
                            }));
                          },
                        );
                      } else {
                        return Container(child: Center());
                      }
                    }),
                Container(
                  padding: const EdgeInsets.only(
                      top: 5, left: 10, right: 10, bottom: 5),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(width: 2)),
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 5, left: 10, right: 10, bottom: 5),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  setState(() {
                                    if (!(likedUsers.contains(user))) {
                                      debugPrint("before liked" +
                                          clickedLike.toString());
                                      likeColor = Colors.blue;
                                      numLikes++;
                                      FirebaseFirestore.instance
                                          .collection('recipe')
                                          .doc(widget.recipeID)
                                          .collection('comments')
                                          .doc(docID)
                                          .update({'likes': numLikes});
                                      clickedLike = !clickedLike;

                                      FirebaseFirestore.instance
                                          .collection('recipe')
                                          .doc(widget.recipeID)
                                          .collection('comments')
                                          .doc(docID)
                                          .update({
                                        'likedUsers':
                                            FieldValue.arrayUnion(list)
                                      });
                                      debugPrint("after liked" +
                                          clickedLike.toString());
                                    } else {
                                      numLikes--;
                                      debugPrint("before dislike" +
                                          clickedLike.toString());
                                      FirebaseFirestore.instance
                                          .collection('recipe')
                                          .doc(widget.recipeID)
                                          .collection('comments')
                                          .doc(docID)
                                          .update({'likes': numLikes});
                                      clickedLike = !clickedLike;
                                      //debugPrint("after change");
                                      FirebaseFirestore.instance
                                          .collection('recipe')
                                          .doc(widget.recipeID)
                                          .collection('comments')
                                          .doc(docID)
                                          .update({
                                        'likedUsers':
                                            FieldValue.arrayRemove(list)
                                      });
                                      debugPrint("after dislike" +
                                          clickedLike.toString());
                                    }
                                  });
                                },
                                icon: Icon(Icons.thumb_up,
                                    color: clickedLike
                                        ? Colors.blue
                                        : Colors.black)
                                //color: Colors.blue,
                                ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 1, right: 3, bottom: 10),
                              //edit button to edit the comments
                              child: Text(numLikes.toString(),
                                  style: const TextStyle(
                                      fontSize: 17.0, color: Colors.black)),
                            ),
                            _checkUser(
                                docID, widget.index, user, 100, likeColor),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 10, left: 3, right: 3, bottom: 10),
                  //edit button to edit the comments
                ),
                // FittedBox(
                //   child: Image.network(
                //     img,
                //     fit: BoxFit.cover,
                //     height: 85,
                //     width: 85,
                //   ),
                // ),
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
    if (widget.snapshot.docs[widget.index]['imgAttached'] == "true") {}
  }

  //method to get the image URL
  Future _getImageURL() async {
    //ref string will change so the parameter will be the jpg ID (maybe)
    String downloadURL = await storage
        .ref('images/' + widget.snapshot.docs[widget.index].id)
        .getDownloadURL();
    return downloadURL;
  }

  _checkUser(String docId, int id, String user, int counter, Color likeColor) {
    if (widget.snapshot.docs[widget.index]['user'] == user) {
      // if (user == user)

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Row(
              children: [
                IconButton(
                    //delete the comment from the database
                    icon: Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      showDeleteAlert(context, docId);
                    }),
              ],
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Row(
              children: [
                IconButton(
                    //delete the comment from the database
                    icon: Icon(
                      Icons.flag,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      showReportAlert(context, docId);
                    }),
              ],
            ),
          ),
        ],
      );
    }
  }

  showDeleteAlert(BuildContext context, var docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Delete comment?'),
          actions: <Widget>[
            TextButton(
              child: new Text("Yes"),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('recipe')
                    .doc(widget.recipeID)
                    .collection('comments')
                    .doc(docId)
                    .delete();
                final snackBar = SnackBar(
                  content: Text('Comment Deleted'),
                  duration: Duration(milliseconds: 1000),
                  backgroundColor: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  showReportAlert(BuildContext context, var docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Report comment?'),
          actions: <Widget>[
            TextButton(
              child: new Text("Yes"),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('recipe')
                    .doc(widget.recipeID)
                    .collection('comments')
                    .doc(docId)
                    .update({'reported': true});
                final snackBar = SnackBar(
                  content: Text('Comment Reported'),
                  duration: Duration(milliseconds: 1000),
                  backgroundColor: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
