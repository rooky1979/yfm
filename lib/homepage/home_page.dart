import 'dart:math';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youth_food_movement/homepage/profile_page.dart';
import 'package:youth_food_movement/homepage/test_grid_tile.dart';
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
  var rand = Random();
  List<String> colours = [
    'Colors.redAccent[700], Colors.red[400]',
  ];
  List categories = [
    'All',
    'Beef',
    'Pork',
    'Poultry',
    'Fish',
    'Shellfish',
    'Pulses',
    'Eggs',
    'Dairy',
    'Pasta',
    'Salads'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: new Color(0xFFf0f1eb),
      appBar: AppBar(
        backgroundColor: new Color(0xFFe62d11),
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
      //this area will create a list of catergories that currently only displays one
      //recipe
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
                    //height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.redAccent[700], Colors.red[400]]),
                        border: Border.all(color: Colors.red[800]),
                        borderRadius: BorderRadius.circular(10)),
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
              Container(
                height: 180.0,
                child: StreamBuilder(
                    //future: getRecipeCategory(categories[index].toString()),
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
                                child: TestGridTile(
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

  // ignore: unused_element
  Future _getImageURL(var docID) async {
    //declare and instantiate the firebase storage bucket
    final FirebaseStorage storage = FirebaseStorage.instanceFor(
        bucket: 'gs://youth-food-movement.appspot.com');
    //ref string will change so the parameter will be the jpg ID (maybe)
    String downloadURL =
        await storage.ref('recipe_images/$docID').getDownloadURL();
    return downloadURL;
  }

  Future getRecipeCategory(String queryString) async {
    var recipeDocRef =
        await FirebaseFirestore.instance.collection('recipe').add({});
    //get the info from the DB
    await recipeDocRef
        .collection("ingredients")
        .where('protein', arrayContains: queryString)
        .get();
  }
}
