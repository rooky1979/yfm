import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youth_food_movement/bookmark/bookmark_tile.dart';
import 'package:youth_food_movement/colours/hex_colours.dart';

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
      backgroundColor: onyx,
      //app bar that contains the search bar and profile settings page

      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[turquoiseGreen, greenSheen],
            ),
          ),
        ),
        title: Text(
          'Favourite Recipes',
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
        ),

        //backgroundColor: Color(0xFF7a243e),
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            size: 25,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, int index) {
              return GestureDetector(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: BookmarkTile(
                    snapshot: snapshot.data,
                    index: index,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
