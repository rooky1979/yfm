import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    String userID = snapshotData['uid'];
    String uid = firebaseAuth.currentUser.uid;
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
            width: MediaQuery.of(context).size.width,
            child: Card(
                elevation: 1,
                shadowColor: Colors.red,
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
                shadowColor: Colors.red,
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
                            ),
                            Flexible(
                              child: Text(
                                '${snapshotData['birthday']}',
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
                shadowColor: Colors.red,
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
                            ),
                            Flexible(
                              child: Text(
                                '${snapshotData['username']}',
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
                shadowColor: Colors.red,
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
                            ),
                            Flexible(
                              child: Text(
                                '${snapshotData['region']}',
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
              shadowColor: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      //height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.redAccent[700], Colors.red[400]]),
                          border: Border.all(color: Colors.red[800]),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Allergies: ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '${snapshotData['allergy']}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
