import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youth_food_movement/colours/hex_colours.dart';

//card layout to display the recipe method
class MethodCard extends StatelessWidget {
  //snapshot of the database
  final QuerySnapshot snapshot;
  final int index;

  const MethodCard({Key key, this.snapshot, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //snaphot of the docs in firebase DB
    var snapshotData = snapshot.docs[index];
    //list created from the method snapshot
    List<String> methodList = List.from(snapshotData['method']);

    return Column(
      children: [
        Padding(
          //widget for the recipe info title
          padding: const EdgeInsets.all(3.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Method:',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        //list view to build the method
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: methodList.length,
          itemBuilder: (context, int index) {
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: darkPurple,
                    child: Text(
                      (index + 1).toString(),
                      style:
                          TextStyle(color: linen, fontWeight: FontWeight.bold),
                    ),
                  ),
                  //each tile prints each element of the array
                  title: Text(
                    methodList[index].toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  height: 10,
                  thickness: 2,
                  indent: 40,
                  endIndent: 20,
                  color: darkPurple,
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
