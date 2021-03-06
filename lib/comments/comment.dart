import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youth_food_movement/colours/hex_colours.dart';

class Comment extends StatefulWidget {
  @override
  _CommentState createState() => _CommentState();
  final QuerySnapshot snapshot;
  final QuerySnapshot userSnapshot;
  final int index;
  final String recipeID;

  const Comment(
      {Key key, this.snapshot, this.userSnapshot, this.index, this.recipeID})
      : super(key: key);
}

class _CommentState extends State<Comment> {
//This instantiates the storage bucket
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: 'gs://youth-food-movement.appspot.com');

//This gets the current user data
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//connection to the db
  var userfirestoreDb =
      FirebaseFirestore.instance.collection('users').snapshots();

  Widget build(BuildContext context) {
//to convert the timestamp into readble format
    var timeToDate = new DateTime.fromMillisecondsSinceEpoch(
        widget.snapshot.docs[widget.index]['timestamp'].seconds * 1000);

//format the timestamp into a readable date
    var dateFormatted = new DateFormat('EEE d MMM, y').format(timeToDate);

//This is the snapshot of all comments associated with a recipe
    var snapshotData = widget.snapshot.docs[widget.index];
    var docID = widget.snapshot.docs[widget.index].id;

    //This String saves the current users user ID for user with the user table
    String user = _firebaseAuth.currentUser.uid;

    //This list is used to add and remove users from the list of users who have liked a comment
    var list = [user];
    List<String> likedUsers = List.from(snapshotData['likedUsers']);

    // ignore: unused_local_variable
    Color likeColor = unliked;

    //This boolean is used to limit how many times a person can like a comment
    bool clickedLike = likedUsers.contains(user);
    var numLikes = snapshotData['likes'];

    return Column(
      children: [
        Container(
          child: Card(
            elevation: 9,
            child: Column(
              children: [
                //tile contents
                ListTile(
                  title: Row(
                    children: [
                      //Future builder allows the app to get user data from db async
                      FutureBuilder(
                        future: _getUserName(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            //return the image and make it cover the container
                            return Container(
                              child: Text(
                                snapshot.data,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15.0),
                              ),
                            );
                          } else {
                            return Container(
                              child: Text('Incoming User Data'),
                            );
                          }
                        },
                      ),
                      Text(
                        " - " + dateFormatted,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12.0),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    snapshotData['description'],
                    style: const TextStyle(fontSize: 17.0, color: Colors.black),
                  ),
                  //Future builder allows the app to get user profile from db async
                  leading: FutureBuilder(
                    future: _getUserImage(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        //return the image and make it cover the container
                        return CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(snapshot.data),
                          backgroundColor: Colors.transparent,
                        );
                      } else {
                        return const Icon(Icons.verified_user_rounded);
                      }
                    },
                  ),
                ),
                //This center contains the comment image
                if (snapshotData['imgAttached'] == true)
                  Center(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                      child: FutureBuilder(
                        future: _getImageURL(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return GestureDetector(
                              child: Image.network(
                                snapshot.data,
                                fit: BoxFit.cover,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
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
                                    },
                                  ),
                                );
                              },
                            );
                          } else {
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 5, left: 10, right: 15, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(width: 2),
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10, bottom: 5),
                          child: Row(
                            children: [
                              //Handles logic for liking comments and unliking comments
                              IconButton(
                                onPressed: () async {
                                  setState(
                                    () {
                                      if (!(likedUsers.contains(user))) {
                                        likeColor = liked;
                                        numLikes++;
                                        FirebaseFirestore.instance
                                            .collection('recipe')
                                            .doc(widget.recipeID)
                                            .collection('comments')
                                            .doc(docID)
                                            .update(
                                          {'likes': numLikes},
                                        );
                                        clickedLike = !clickedLike;
                                        FirebaseFirestore.instance
                                            .collection('recipe')
                                            .doc(widget.recipeID)
                                            .collection('comments')
                                            .doc(docID)
                                            .update(
                                          {
                                            'likedUsers':
                                                FieldValue.arrayUnion(list)
                                          },
                                        );
                                      } else {
                                        numLikes--;
                                        FirebaseFirestore.instance
                                            .collection('recipe')
                                            .doc(widget.recipeID)
                                            .collection('comments')
                                            .doc(docID)
                                            .update(
                                          {'likes': numLikes},
                                        );
                                        clickedLike = !clickedLike;

                                        FirebaseFirestore.instance
                                            .collection('recipe')
                                            .doc(widget.recipeID)
                                            .collection('comments')
                                            .doc(docID)
                                            .update(
                                          {
                                            'likedUsers':
                                                FieldValue.arrayRemove(list)
                                          },
                                        );
                                      }
                                    },
                                  );
                                },
                                icon: Icon(Icons.thumb_up,
                                    color: clickedLike ? liked : black),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 1, right: 3, bottom: 10),
                                child: Text(
                                  numLikes.toString(),
                                  style: const TextStyle(
                                      fontSize: 17.0, color: Colors.black),
                                ),
                              ),
                              //Create Delete or Report Button depending on current user
                              _checkUser(docID, widget.index, user),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 10, left: 3, right: 3, bottom: 10),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  //This method gets the image associated with a comment from the database

  Future _getImageURL() async {
    String downloadURL = await storage
        .ref('comment_images/' + widget.snapshot.docs[widget.index].id)
        .getDownloadURL();
    return downloadURL;
  }

  // This method pulls the user avatar from the database
  // based on the image name saved

  Future _getUserImage() async {
    String imageName;

    await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: widget.snapshot.docs[widget.index]['uid'])
        .get()
        .then(
      (QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach(
          (doc) {
            imageName = doc["image"];
          },
        );
      },
    );

    String downloadURL =
        await storage.ref('avatar_images/' + imageName).getDownloadURL();
    return downloadURL;
  }

  // This method pulls the username associated with the comment
  // and returns it to the Future Builder

  Future _getUserName() async {
    String username;
    await FirebaseFirestore.instance
        .collection('users') // Users table in firestore
        .where('uid',
            isEqualTo: widget.snapshot.docs[widget.index][
                'uid']) //first uid is the user ID of in the users table (not document id)
        .get()
        .then(
      (QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach(
          (doc) {
            username = doc["username"];
          },
        );
      },
    );
    return username;
  }

  // This method compares the current active user to the user associated with the comment,
  // If the users match it creates the delete button. Otherwise it creates a report button.

  _checkUser(String docId, int id, String user) {
    if ((widget.snapshot.docs[widget.index]['uid'] == user ||
        user == 'insert current UID Here'))
    {
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
                    color: buttonPrimary,
                  ),
                  onPressed: () async {
                    showDeleteAlert(context, docId);
                  },
                ),
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
                    color: buttonPrimary,
                  ),
                  onPressed: () async {
                    showReportAlert(context, docId);
                  },
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  // This method creates the sequence for comment delete confirmation.

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
                  backgroundColor: orangeRed,
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

  // This method creates the alert dialog sequence for confirming reporting of a comment.

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
                    .update(
                  {'reported': true},
                );
                final snackBar = SnackBar(
                  content: Text('Comment Reported'),
                  duration: Duration(milliseconds: 1000),
                  backgroundColor: orangeRed,
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
