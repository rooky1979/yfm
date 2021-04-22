import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:youth_food_movement/recipe/ui/ingredients_page.dart';

//card that displays the recipe information
class TestGridTile extends StatelessWidget {
  //snapshot of the database
  final QuerySnapshot snapshot;
  final int index;
  const TestGridTile({Key key, this.snapshot, this.index}) : super(key: key);
  static String idNumber;

  @override
  Widget build(BuildContext context) {
    //snaphot of the docs
    // ignore: unused_local_variable
    var snapshotData = snapshot.docs[index];
    var docID = snapshot.docs[index].id;
    String recipeID = docID.toString();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      //get the image URL
      child: FutureBuilder(
          future: _getImageURL(docID),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //return the image and make it cover the container
              return GestureDetector(
                child: Image.network(
                  snapshot.data,
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  idNumber = recipeID;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              IngredientsPage(recipeID)));
                },
              );
            } else {
              return Container(
                  child: Center(
                child: CircularProgressIndicator(),
              ));
            }
          }),
    );
  }

  //method to get the image URL
  Future _getImageURL(var docID) async {
    //declare and instantiate the firebase storage bucket
    final FirebaseStorage storage = FirebaseStorage.instanceFor(
        bucket: 'gs://youth-food-movement.appspot.com');
    //ref string will change so the parameter will be the jpg ID (maybe)
    String downloadURL =
        await storage.ref('recipe_images/$docID').getDownloadURL();
    return downloadURL;
  }
}
