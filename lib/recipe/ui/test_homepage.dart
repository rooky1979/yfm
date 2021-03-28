//test homepage to test the recipe process

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:youth_food_movement/recipe/ui/ingredients_page.dart';

class TestHomepage extends StatelessWidget {
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: 'gs://youth-food-movement.appspot.com');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        title: Text('TEST HOMEPAGE FOR RECIPE'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: _getImageURL(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //return the image and make it cover the container
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: GestureDetector(
                      child: Image.network(
                        snapshot.data,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    IngredientsPage()));
                      },
                    ),
                  ),
                );
              } else {
                return Container(
                    child: Center(
                  child: CircularProgressIndicator(),
                ));
              }
            }),
      ),
    );
  }

  //method to get the image URL
  Future _getImageURL() async {
    //ref string will change so the parameter will be the jpg ID (maybe)
    String downloadURL = await storage.ref('prawnpasta.jpg').getDownloadURL();
    return downloadURL;
  }
}
