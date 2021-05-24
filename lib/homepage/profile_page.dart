import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:youth_food_movement/bookmark/bookmark_page.dart';
import 'package:youth_food_movement/colours/hex_colours.dart';
import 'package:youth_food_movement/homepage/user_information_card.dart';
import 'package:youth_food_movement/login/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youth_food_movement/login/login_page.dart';
import 'package:youth_food_movement/recipe_submission/ui/recipe_submit_info.dart';
import 'package:url_launcher/url_launcher.dart';

//a profile page to hold the user information and to display all the information
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
      backgroundColor: background,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[gradientColourA, gradientColourB],
            ),
          ),
        ),
        title: Text(
          'Profile Information',
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
        ),
        leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              size: 25,
              color: white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                child: Container(
                  width: 200.0,
                  height: 180.0,
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
                                  //make the picture full screen onTap
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
            ),
            ProfileButtons(),
            Padding(
              padding: const EdgeInsets.only(
                  left: 13.0, right: 13.0, top: 12.0, bottom: 1.0),
            ),
            StreamBuilder(
              stream: firestoreDb,
              builder: (
                context,
                snapshot,
              ) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, int index) {
                      return UserInformationCard(
                        snapshot: snapshot.data,
                        index: 1,
                      );
                    },
                  ),
                );
              },
            ),
            //sign out of the account button
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                width: MediaQuery.of(context).size.width * .90,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    primary: orangeRed, // background
                    onPrimary: white, // foreground
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<AuthenticationService>().signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text("SIGN OUT"),
                ),
              ),
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
    debugPrint(downloadURL);
    return downloadURL;
  }
}

class ProfileButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 2.0, left: 3.0, right: 3.0, bottom: 2.0),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * .90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: barColor,
          border: Border.all(color: buttonPrimary, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RawMaterialButton(
              padding: EdgeInsets.all(10),
              fillColor: white,
              shape: CircleBorder(
                side: BorderSide(color: buttonPrimary),
              ),
              child:
                  Icon(FontAwesomeIcons.globe, size: 28, color: buttonPrimary),
              onPressed: _launchURL,
            ),
            RawMaterialButton(
              padding: EdgeInsets.all(10),
              fillColor: white,
              shape: CircleBorder(
                side: BorderSide(color: buttonPrimary),
              ),
              child: Icon(
                FontAwesomeIcons.solidBookmark,
                size: 28,
                color: buttonPrimary,
              ),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => BookmarkPage(),
                  ),
                )
              },
            ),
            _checkMod(context)
          ],
        ),
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://nutritionfoundation.org.nz/about-us';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

//currently unused method to validate if the user is a moderator or not
_checkMod(BuildContext context) {
  //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  return RawMaterialButton(
    padding: EdgeInsets.all(11),
    fillColor: white,
    shape: CircleBorder(
      side: BorderSide(color: buttonPrimary),
    ),
    child: Icon(FontAwesomeIcons.plusCircle, size: 28, color: buttonPrimary),
    onPressed: () => {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => InformationSubmission(),
        ),
      ),
    },
  );
}
