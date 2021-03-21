import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//card that displays the recipe information
class RecipeInformationCard extends StatelessWidget {
  //snapshot of the database
  final QuerySnapshot snapshot;
  final int index;

  const RecipeInformationCard({Key key, this.snapshot, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //snaphot of the docs
    var snapshotData = snapshot.docs[index];
    //snapshot document ID for use later
    // ignore: unused_local_variable
    var docID = snapshot.docs[index].id;
    List<String> ingredientsList = List.from(snapshotData['ingredients']);

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
                    ),_++
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              '${snapshotData['title']}',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              '${snapshotData['description']}',
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
                    //widget for the recipe info subheading
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Information:',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    //widget to show the serving size
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text.rich(TextSpan(
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Servings: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: snapshotData['servings']),
                              ])),
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
                    //widget to display the prep time
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        snapshotData['prepTime'] < 60
                            ? Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text.rich(TextSpan(
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Prep Time: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: _printPrepTimeMinutes(
                                                  snapshotData)
                                              .toString()),
                                    ])),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text.rich(TextSpan(
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Prep Time: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              _printPrepTimeHours(snapshotData)
                                                      .toString() +
                                                  ' ' +
                                                  _printPrepTimeMinutes(
                                                          snapshotData)
                                                      .toString()),
                                    ])),
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
                          child: Text.rich(TextSpan(
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Allergies: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text:
                                        _printArray(snapshotData['allergies'])),
                              ])),
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
                            child: Text.rich(TextSpan(
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Protein: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          _printArray(snapshotData['protein'])),
                                ])),
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
                    //widget showing vege, non-vege or vegan
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text('${snapshotData['category']}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Column(
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
              //widget for the recipe info title
              padding: const EdgeInsets.all(3.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text('Ingredients:',
                        style:
                            TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: ingredientsList.length,
                itemBuilder: (context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 10,
                        ),
                        title: Text(ingredientsList[index].toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      Divider(
                        height: 10,
                        thickness: 2,
                        indent: 40,
                        endIndent: 20,
                        color: Colors.red[200],
                      ),
                    ],
                  );
                })
          ],
        )
      ],
    );
  }

  //helper method to calculate the mins and catch the minutes where singular or plural
  // ignore: missing_return
  String _printPrepTimeMinutes(var snapshotData) {
    int minutes = snapshotData['prepTime'] % 60;

    if (minutes == 0) {
      return ' ';
    }

    if (snapshotData['prepTime'] < 60 || minutes != 0) {
      if (minutes == 1) {
        return minutes.toString() + ' min';
      } else {
        return minutes.toString() + ' mins';
      }
    }
  }

  //helper method to calculate and print the hours singular or plural
  // ignore: missing_return
  String _printPrepTimeHours(var snapshotData) {
    double hours = snapshotData['prepTime'] / 60;
    if (hours >= 1) {
      if (hours.toStringAsFixed(0) == '1') {
        return hours.toStringAsFixed(0) + ' hour';
      } else {
        return hours.toStringAsFixed(0) + ' hours';
      }
    }
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

//helper method to print arrays in a list form
String _printArrayList(var snapshotData) {
  String string = '';

  for (int i = 0; i < snapshotData.length; ++i) {
    string += '- ';
    string += snapshotData[i];
    string += '\n';
  }
  return string;
}
