import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:youth_food_movement/homepage/profile_page.dart';
import 'package:youth_food_movement/recipe/ui/recipe_controls_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: 'gs://youth-food-movement.appspot.com');

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
      body: SafeArea(
          child: Container(
        alignment: Alignment.bottomRight,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 100.0,
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (BuildContext context, int categoryIndex) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('category ${categoryIndex + 1}'),
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
                              future: _getImageURL(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  //return the image and make it cover the container
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
                                              RecipeControlsPage(),
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

  Future _getImageURL() async {
    //ref string will change so the parameter will be the jpg ID (maybe)
    String downloadURL = await storage.ref('prawnpasta.jpg').getDownloadURL();
    return downloadURL;
  }
}
