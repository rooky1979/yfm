import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData extends StatefulWidget {
  @override
  _UserDataState createState() => _UserDataState();
  final QuerySnapshot snapshot;
  final QuerySnapshot userSnapshot;
  final int index;
  final String userID;

  const UserData(
      {Key key, this.snapshot, this.userSnapshot, this.index, this.userID})
      : super(key: key);
}

class _UserDataState extends State<UserData> {
//This instantiates the storage bucket
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: 'gs://youth-food-movement.appspot.com');

//This gets the current user data
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
//to convert the timestamp into readble format
    var timeToDate = new DateTime.fromMillisecondsSinceEpoch(
        widget.snapshot.docs[widget.index]['timestamp'].seconds * 1000);

//format the timestamp into a readable date
    var dateFormatted = new DateFormat('EEE d MMM, y').format(timeToDate);

//This is the snapshot of all comments associated with a users
    var snapshotData = widget.snapshot.docs[widget.index];
    var docID = widget.snapshot.docs[widget.index].id;

    //This String saves the current users user ID for user with the user table
    String user = _firebaseAuth.currentUser.uid;

    //This list is used to add and remove users from the list of users who have liked a comment
    var list = [user];
    List<String> likedUsers = List.from(snapshotData['likedUsers']);
    Color likeColor = Colors.grey;

    //This boolean is used to limit how many times a person can like a comment
    bool clickedLike = likedUsers.contains(user);
    var numLikes = snapshotData['likes'];

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
                  title: Row(children: [
                    //Future builder allows the app to get user data from db async
                    FutureBuilder(
                        future: _getUserName(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            //return the image and make it cover the container
                            return Container(
                              child: Text(snapshot.data,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15.0)),
                            );
                          } else {
                            return Container(child: Text('Incoming User Data'));
                          }
                        }),
                    Text(" - " + dateFormatted,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12.0)),
                  ]),
                  subtitle: Text(snapshotData['description'],
                      style:
                          const TextStyle(fontSize: 17.0, color: Colors.black)),
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
                      }),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  /*
   * This method pulls the user avatar from the database 
   * (Needs to change to use the string stored in db)
   */
  Future _getUserImage() async {
    String downloadURL = await storage.ref('avatar1.jpg').getDownloadURL();
    return downloadURL;
  }

  /*
   * This method pulls the username associated with the comment
   */
  Future _getUserName() async {
    String username;
    await FirebaseFirestore.instance
        .collection('users') // Users table in firestore
        .where('uid',
            isEqualTo: widget.snapshot.docs[widget.index][
                'uid']) //first uid is the user ID of in the users table (not document id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        username = doc["username"];
      });
    });
    return username;
  }
}
