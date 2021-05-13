import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:youth_food_movement/homepage/profile_page.dart';
import 'package:youth_food_movement/homepage/test_grid_tile.dart';
import 'package:youth_food_movement/login/user_search/data_controller.dart';

class TestHomepage extends StatefulWidget {
  @override
  _TestHomepageState createState() => _TestHomepageState();
}

class _TestHomepageState extends State<TestHomepage> {
  var firestoreDb = FirebaseFirestore.instance.collection('recipe').snapshots();
  final TextEditingController searchController = TextEditingController();
  QuerySnapshot snapshotData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar that contains the search bar and profile settings page
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        actions: [
          GetBuilder<DataController>(
              init: DataController(),
              builder: (val) {
                return Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          val
                              //on pressing search, it invokes the search method from data_contriller.dart
                              .foodTitleQueryData(searchController.text)
                              .then((value) {
                            snapshotData = value;
                            setState(() {});
                          });
                        }),
                    //button for the settings page
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()),
                          );
                        },
                        icon: Icon(Icons.settings)),
                  ],
                );
              })
        ],
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
                ),
              ],
            )),
      ),
      body: StreamBuilder(
          stream: firestoreDb,
          builder: (
            context,
            snapshot,
          ) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return GridView.builder(
                //scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
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
}
