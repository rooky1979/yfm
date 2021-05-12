import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youth_food_movement/bookmark/bookmark_tile.dart';
import 'package:youth_food_movement/homepage/profile_page.dart';
import 'package:youth_food_movement/homepage/homepage_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youth_food_movement/recipe/ui/recipe_controls_page.dart';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}
class _BookmarkPageState extends State<BookmarkPage> {
  var firestoreDb = FirebaseFirestore.instance.collection('recipe').snapshots();
  final TextEditingController searchController = TextEditingController();
  QuerySnapshot snapshotData;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //app bar that contains the search bar and profile settings page
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              size: 25,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Favourite Recipes',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
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
                      child: BookmarkTile(
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
