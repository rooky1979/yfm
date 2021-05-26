import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youth_food_movement/colours/hex_colours.dart';
import 'package:youth_food_movement/homepage/profile_page.dart';
import 'package:youth_food_movement/homepage/homepage_tile.dart';
import 'package:youth_food_movement/login/user_search/data_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//main homepage class displaying the recipe thumbnails in their categories
class _HomePageState extends State<HomePage> {
  //connection to image storage
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: 'gs://youth-food-movement.appspot.com');
//input text controller
  final TextEditingController searchController = TextEditingController();
  QuerySnapshot snapshotData;
  var firestoreDb = FirebaseFirestore.instance.collection('recipe').snapshots();
  //list to hold the categories
  List categories = [
    'All',
    'Beef',
    'Salads',
    'Poultry',
    'Fish',
    'Shellfish',
    'Pulses',
    'Eggs',
    'Dairy',
    'Pasta',
    'Rice',
    'Dessert'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[gradientColourA, gradientColourB],
            ),
          ),
        ),
        title: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search",
            fillColor: textfieldBackground,
            hintStyle: TextStyle(
              color: white,
              fontSize: 20,
            ),
          ),
        ),
        actions: [
          GetBuilder<DataController>(
            init: DataController(),
            builder: (val) {
              return Row(
                children: [
                  //search function
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      val.foodTitleQueryData(searchController.text).then(
                        (value) {
                          snapshotData = value;
                          setState(() {});
                        },
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
//creates the category name and list tiles
      body: SafeArea(
        child: Container(
          alignment: Alignment.bottomRight,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 100.0,
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [categoryColourA, categoryColourB],
                        ),
                        border: Border.all(
                          color: Colors.green[50],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '${categories[index]}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                //creates the horizontal scrolling list of recipe tiles
                Container(
                  height: 180.0,
                  child: StreamBuilder(
                    stream: firestoreDb,
                    builder: (
                      context,
                      snapshot,
                    ) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, int index) {
                          return GestureDetector(
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: HomepageTile(
                                snapshot: snapshot.data,
                                index: index,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
