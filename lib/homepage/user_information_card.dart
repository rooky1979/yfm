import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youth_food_movement/colours/hex_colours.dart';

//card that displays the recipe information
class UserInformationCard extends StatelessWidget {
  //snapshot of the database
  final QuerySnapshot snapshot;
  final int index;
  const UserInformationCard({Key key, this.snapshot, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    //snaphot of the doc
    int userindex = 0;
    var snapshotData = snapshot.docs[userindex];
    //snapshot document ID for use later
    // ignore: unused_local_variable
    String docID = snapshot.docs[userindex].id;
    String uid = firebaseAuth.currentUser.uid;
    String userID = snapshotData['uid'];
    while (userID != uid) {
      userindex++;
      snapshotData = snapshot.docs[userindex];
      userID = snapshotData['uid'];
    }
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.fill,
          child: Container(
<<<<<<< HEAD
            width: MediaQuery.of(context).size.width,
            child: Card(
                elevation: 1,
                shadowColor: new Color(0xFFe62d11),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.redAccent[700],
                              Colors.red[400]
                            ]),
                            border: Border.all(color: Colors.red[800]),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Name: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '${snapshotData['name']}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
        FittedBox(
          fit: BoxFit.fill,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
                elevation: 1,
                shadowColor: new Color(0xFFe62d11),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.redAccent[700],
                              Colors.red[400]
                            ]),
                            border: Border.all(color: Colors.red[800]),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Birthday: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                                textAlign: TextAlign.center,
                              ),
=======
              padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .90,
                    //height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[ceruleanCrayola, celadonBlue]),
                        border: Border.all(color: Colors.blue[900], width: 1.5),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'Name: ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              textAlign: TextAlign.center,
>>>>>>> d52dabf693938741cd35925b142d634cae66eb35
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${snapshotData['name']}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
        FittedBox(
          fit: BoxFit.fill,
          child: Container(
<<<<<<< HEAD
            width: MediaQuery.of(context).size.width,
            child: Card(
                elevation: 1,
                shadowColor: new Color(0xFFe62d11),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.redAccent[700],
                              Colors.red[400]
                            ]),
                            border: Border.all(color: Colors.red[800]),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Username: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                                textAlign: TextAlign.center,
                              ),
=======
              padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .90,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[ceruleanCrayola, celadonBlue]),
                        //color: Color(0xFFe62d1),
                        border: Border.all(color: Colors.blue[900], width: 1.5),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'Username: ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              textAlign: TextAlign.center,
>>>>>>> d52dabf693938741cd35925b142d634cae66eb35
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${snapshotData['username']}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
        FittedBox(
          fit: BoxFit.fill,
          child: Container(
<<<<<<< HEAD
            width: MediaQuery.of(context).size.width,
            child: Card(
                elevation: 1,
                shadowColor: new Color(0xFFe62d11),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.redAccent[700],
                              Colors.red[400]
                            ]),
                            border: Border.all(color: Colors.red[800]),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Region: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                                textAlign: TextAlign.center,
                              ),
=======
              padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .90,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[ceruleanCrayola, celadonBlue]),
                        //color: Color(0xFFe62d1),
                        border: Border.all(color: Colors.blue[900], width: 1.5),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'Birthday: ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              textAlign: TextAlign.center,
>>>>>>> d52dabf693938741cd35925b142d634cae66eb35
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${snapshotData['birthday']}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
        FittedBox(
          fit: BoxFit.fill,
          child: Container(
<<<<<<< HEAD
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 1,
              shadowColor: new Color(0xFFe62d11),
=======
              padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
              width: MediaQuery.of(context).size.width,
>>>>>>> d52dabf693938741cd35925b142d634cae66eb35
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .90,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[ceruleanCrayola, celadonBlue]),
                        //color: Color(0xFFe62d1),
                        border: Border.all(color: Colors.blue[900], width: 1.5),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'Region: ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${snapshotData['region']}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
        FittedBox(
          fit: BoxFit.fill,
          child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .90,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[ceruleanCrayola, celadonBlue]),
                        //color: Color(0xFFe62d1),
                        border:
                            Border.all(color: Colors.blue[900], width: 1.5),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text.rich(TextSpan(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Allergies: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: _printArray(snapshotData['allergy'])),
                              ])),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  //helper method to print the array
  String _printArray(var snapshotData) {
    String string = '';

    for (int i = 0; i < snapshotData.length; ++i) {
      string += snapshotData[i];
      if (i < snapshotData.length - 1) {
        string += ', ';
      }
    }
    return string;
  }
}
