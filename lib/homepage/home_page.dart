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

class _HomePageState extends State<HomePage> {
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: 'gs://youth-food-movement.appspot.com');
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
    'Rice'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[mintGreen, emerald])),
        ),
        actions: [
          GetBuilder<DataController>(
              init: DataController(),
              builder: (val) {
                return Row(
                  children: [
                    //search function
                    IconButton(
                        icon: Icon(Icons.search, color: Colors.white,),
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
                        icon: Icon(Icons.settings, color: Colors.white,)),
                  ],
                );
              })
        ],
        //search bar textfield
        title: Container(
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5.0),
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
                    height: 45,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [zomp, emerald]),
                        border: Border.all(color: Colors.green[50]),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '${categories[index]}',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
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
                                    borderRadius: BorderRadius.circular(10)),
                                child: HomepageTile(
                                  snapshot: snapshot.data,
                                  index: index,
                                ),
                              ),
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
