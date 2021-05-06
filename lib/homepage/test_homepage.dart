import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youth_food_movement/homepage/profile_page.dart';
import 'package:youth_food_movement/recipe/ui/test_grid_tile.dart';

class TestHomepage extends StatefulWidget {
  @override
  _TestHomepageState createState() => _TestHomepageState();
}

class _TestHomepageState extends State<TestHomepage> {
  var arr = ['dead index', 'Beef', 'Pork', 'Dairy', 'Vege', 'Chicken'];
  var firestoreDb = FirebaseFirestore.instance.collection('recipe').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Container(
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5.0),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.all(Radius.zero)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Row(),
                )
              ],
            )),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              icon: Icon(Icons.settings)),
        ],
      ),
      body: new ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: <Widget>[
          new SizedBox(height: 20.0),
          new Container(
            child: new ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return new Column(
                  children: <Widget>[
                    new Container(
                      height: 50.0,
                      color: Colors.red,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Padding(
                              padding: const EdgeInsets.only(right: 5.0)),
                          new Text(
                            arr[index + 1],
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Container(
                      height: 150.0,
                      child: new ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return new Card(
                            elevation: 5.0,
                            child: new Row(
                              children: [
                                TestGridTile(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    new SizedBox(height: 20.0),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
/*
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: StreamBuilder(
        stream: firestoreDb,
        builder: (
          context,
          snapshot,
        ) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return GridView.builder(
              itemCount: snapshot.data.docs.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, int index) {
                return GestureDetector(
                  child: Card(
                    child: TestGridTile(
                      snapshot: snapshot.data,
                      index: index,
                    ),
                  ),
                );
              });
        }),
  );
}
*/
