import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youth_food_movement/homepage/user_information_card.dart';
import 'package:youth_food_movement/login/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

//a temp page to hold the user information and to display all the information
//related to the user that they may want to see/edit

@override
Widget build(BuildContext context) {
  return Center();
}

// ignore: must_be_immutable
class SettingsPage extends StatelessWidget {
  var firestoreDb = FirebaseFirestore.instance.collection('users').snapshots();
  //declare and instantiate the firebase storage bucket
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: 'gs://youth-food-movement.appspot.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Card(
          child: Container(
            width: 200.0,
            height: 200.0,
            decoration: new BoxDecoration(),
            child: FutureBuilder(
                future: _getUserImage(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    //return the image and make it cover the container
                    return GestureDetector(
                      child: Image.network(
                        snapshot.data,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
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
                    return Container(
                        child: Center(
                      child: CircularProgressIndicator(),
                    ));
                  }
                }),
          ),
        ),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return Colors.red;
                },
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              context.read<AuthenticationService>().signOut();
            },
            child: Text("Sign Out")),
        StreamBuilder(
            stream: firestoreDb,
            builder: (
              context,
              snapshot,
            ) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return Expanded(
                child: ListView.builder(
                    itemCount: 1, //snapshot.data.docs.length,
                    itemBuilder: (context, int index) {
                      return UserInformationCard(
                        snapshot: snapshot.data,
                        index:
                            1, //this changes depending on what user is selected
                        //index will be used
                      );
                    }),
              );
            }),
      ])),
    );
  }

  //method to get the image URL
  Future _getImageURL() async {
    //ref string will change so the parameter will be the jpg ID (maybe)
    String downloadURL = await storage.ref('avatar1.jpg').getDownloadURL();
    return downloadURL;
  }

  Future _getUserImage() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    String imageName;

    await FirebaseFirestore.instance
        .collection('users') // Users table in firestore
        .where('uid',
            isEqualTo: _firebaseAuth.currentUser
                .uid) //first uid is the user ID of in the users table (not document id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        imageName = doc["image"];
      });
    });

    String downloadURL =
        await storage.ref('avatar_images/' + imageName).getDownloadURL();
    debugPrint(downloadURL);
    return downloadURL;
  }
}

class FirebaseApp {}
