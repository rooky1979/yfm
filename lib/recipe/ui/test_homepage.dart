import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youth_food_movement/recipe/ui/ingredients_page.dart';
import 'package:youth_food_movement/recipe/ui/test_grid_tile.dart';

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
        title: Text('Test Homepage'),
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
