import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//card that displays the recipe information
class UserInformationCard extends StatelessWidget {
  //snapshot of the database
  final QuerySnapshot snapshot;
  final int index;
  const UserInformationCard({Key key, this.snapshot, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //snaphot of the doc
    int userindex = 0;
    var snapshotData = snapshot.docs[userindex];
    //snapshot document ID for use later
    // ignore: unused_local_variable
    var docID = snapshot.docs[index].id;
    var userID = snapshotData['uid'];
    if (userID != docID) {
      userindex += 1;
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
                    Divider(
                      height: 10,
                      thickness: 3,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.redAccent,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Birthday: ${snapshotData['Birthday']}',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                  Divider(
                    height: 10,
                    thickness: 3,
                    indent: 10,
                    endIndent: 10,
                    color: Colors.redAccent,
                  ),
                  Padding(
                    //widget to show the serving size
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: userID,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: snapshotData['Name'],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                    color: Colors.red[200],
                  ),
                  Padding(
                    //widget to show the serving size
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: docID,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: snapshotData['Region'],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                    color: Colors.red[200],
                  ),
                  Padding(
                    //widget to show what allergies the recipes affects
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Allergies: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: _printArray(
                                    snapshotData['Allergy'],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                    color: Colors.red[200],
                  ),
                  Padding(
                    //widget showing protein e.g. beef, pork, chicken, fish, shellfish, etc
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Username: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: snapshotData['Username'],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                    color: Colors.red[200],
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
