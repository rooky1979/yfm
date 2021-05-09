import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youth_food_movement/homepage/profile_page.dart';
import 'package:youth_food_movement/login/user_search/data_controller.dart';
import 'package:youth_food_movement/recipe/ui/ingredients_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: 'gs://youth-food-movement.appspot.com');
  final TextEditingController searchController = TextEditingController();
  QuerySnapshot snapshotData;

  @override
  Widget build(BuildContext context) {
    int categoryIndex = 0;
    String category;
    if (categoryIndex == 0) {
      category = 'Beef';
    } else if (categoryIndex == 1) {
      category = 'Pork';
    } else if (categoryIndex == 2) {
      category = 'Chicken';
    } else {
      category = 'Vege';
    }
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
      //this area will create a lister of catergories that currently only displays one
      //recipe

      body: SafeArea(
          child: Container(
        alignment: Alignment.bottomRight,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 100.0,
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (BuildContext context, categoryIndex) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('category ${categoryIndex + 1}'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(category),
              ),
              Container(
                height: 180.0,
                child: PageView.builder(
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      2,
                      (cardIndex) => GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 32.0) / 2,
                          height: 200.0,
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(8.0),
                          child: Card(
                            child: FutureBuilder(
                              // future: _getImageURL(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  //this creates the pictures to be clickable
                                  //and will take the user to the recipe page
                                  return GestureDetector(
                                    child: Image.network(
                                      snapshot.data,
                                      fit: BoxFit.cover,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              IngredientsPage(),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  // Future _getImageURL() async {
  //ref string will change so the parameter will be the jpg ID (maybe)
  //  String downloadURL = await storage.ref('prawnpasta.jpg').getDownloadURL();
  //return downloadURL;
  //}
}
