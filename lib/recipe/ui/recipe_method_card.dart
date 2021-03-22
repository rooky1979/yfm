import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      mainAxisSize: MainAxisSize.min,
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                      title: Text(methodList[index].toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Divider(
                      height: 10,
                      thickness: 3,
                      indent: 40,
                      endIndent: 10,
                      color: Colors.redAccent,
                    ),
                  ],
                );
                /* return Card(
                  elevation: 2,
                  shadowColor: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(methodList[index].toString(),
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 10,
                        thickness: 3,
                        indent: 10,
                        endIndent: 10,
                        color: Colors.redAccent,
                      ),
                    ],
                  ),
                ); */
              }),
        )
      ],
    );

    /* return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.55,
            child: SingleChildScrollView(
              child: Card(
                elevation: 9,
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
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          Text('Method:',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Divider(
                      height: 10,
                      thickness: 3,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.redAccent,
                    ),
                    
                    ListView.builder(
                      itemCount: snapshotData['method'].length,
                      itemBuilder: (BuildContext context, snapshotData){
                        return Card(
                          child: Row(

                            
                          )
                        );
                      })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createMethod(var snapshotData) {
    
    for (int i = 0; i < snapshotData.length; i++) {
      return Card(
        child: Flexible(
                  child: Text(snapshotData[i],
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
      );
    }

  }
 */
//helper method to print arrays
/*   String _printArray(var snapshotData) {
    var string = '';

    for (int i = 0; i < snapshotData.length; ++i) {
      string += '${i + 1}. ';
      string += snapshotData[i];
      string += '\n\n';
    }
    return string;
  } */
  }
}
