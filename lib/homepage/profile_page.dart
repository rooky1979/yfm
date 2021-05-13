import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:youth_food_movement/bookmark/bookmarks.dart';
import 'package:youth_food_movement/homepage/user_information_card.dart';
import 'package:youth_food_movement/login/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youth_food_movement/login/login_page.dart';
import 'package:youth_food_movement/recipe_submission/ui/recipe_submit_info.dart';
import 'package:url_launcher/url_launcher.dart';
//a temp page to hold the user information and to display all the information
//related to the user that they may want to see/edit

@override
Widget build(BuildContext context) {
  return Center();
}

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  var firestoreDb = FirebaseFirestore.instance.collection('users').snapshots();
  //declare and instantiate the firebase storage bucket
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: 'gs://youth-food-movement.appspot.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: new Color(0xFFe62d11),
        title: Container(
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5.0),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.all(Radius.zero)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: Row(),
                ),
              ],
            )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ProfileButtons(),
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
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return new Color(0xFFe62d11);
                  },
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                context.read<AuthenticationService>().signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()));
              },
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }

  //method to get the image URL

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

class ProfileButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, left: 3.0, right: 3.0),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: new Color(0xFFe62d11),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RawMaterialButton(
                padding: EdgeInsets.all(10),
                fillColor: Colors.white,
                shape: CircleBorder(),
                child: Icon(FontAwesomeIcons.globe,
                    size: 40, color: new Color(0xFFe62d11)),
                onPressed: _launchURL,
              ),
              RawMaterialButton(
                  padding: EdgeInsets.all(10),
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  child: Icon(
                    FontAwesomeIcons.solidBookmark,
                    size: 40,
                    color: new Color(0xFFe62d11),
                  ),
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    BookmarkedRecipeThumbnail()))
                      }),
              _checkMod(context)
            ],
          ),
        ),
      ),
    );
  }
}

_launchURL() async {
  const url = 'http://justcook.co.nz/about-us';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_checkMod(BuildContext context) {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  if (_firebaseAuth.currentUser.uid == 'rrFOtlLNLdedqQG9cwsZt3CCjmQ2') {
    return RawMaterialButton(
        padding: EdgeInsets.all(11),
        fillColor: Colors.white,
        shape: CircleBorder(),
        child: Icon(FontAwesomeIcons.plusCircle, size: 40, color: Colors.red),
        onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          InformationSubmission()))
            });
  } else {
    return Container();
  }
}
