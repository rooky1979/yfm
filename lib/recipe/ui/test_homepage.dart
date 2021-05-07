import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:youth_food_movement/homepage/profile_page.dart';
import 'package:youth_food_movement/login/user_search/data_controller.dart';
import 'package:youth_food_movement/recipe/ui/test_grid_tile.dart';
import 'dart:ui';
import 'package:get/get.dart';

class TestHomepage extends StatefulWidget {
  @override
  _TestHomepageState createState() => _TestHomepageState();
}

class _TestHomepageState extends State<TestHomepage> {
  var firestoreDb = FirebaseFirestore.instance.collection('recipe').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
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
                              .foodTitleQueryData(searchController.text)
                              .then((value) {
                            snapshotData = value;
                            setState(() {});
                          });
                        }),
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
                itemCount: snapshot.data.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
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
}
