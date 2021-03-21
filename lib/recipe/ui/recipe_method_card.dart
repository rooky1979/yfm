import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//test comment
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
    //snapshot document ID for use later
    // ignore: unused_local_variable
    var docID = snapshot.docs[index].id;
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
                child: Text('Method:',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: methodList.length,
            itemBuilder: (context, int index) {
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(methodList[index].toString(),
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
    );

    /* return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Method:',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),
              ],
            )),
        Divider(
          height: 10,
          thickness: 3,
          indent: 10,
          endIndent: 10,
          color: Colors.redAccent,
        ),
        SingleChildScrollView(
                  child: ListView.builder(
              //scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: methodList.length,
              itemBuilder: (context, int index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          )),
                      title: Text(methodList[index].toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Divider(
                      height: 10,
                      thickness: 2,
                      indent: 40,
                      endIndent: 10,
                      color: Colors.red[200],
                    ),
                  ],
                );
              }),
        )
      ],
    ); */
  }
}
