import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youth_food_movement/recipe/ui/recipe_controls_page.dart';
import 'package:youth_food_movement/recipe/ui/recipe_method_card.dart';
import 'package:youth_food_movement/recipe/ui/recipe_method_card.dart';
import 'package:youth_food_movement/recipe/ui/recipe_controls_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookMark extends StatefulWidget {
  @override
  _BookMarkState createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: 'gs://youth-food-movement.appspot.com');

  var firestoreDbMethod =
      FirebaseFirestore.instance.collection('method').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: IconButton(
              icon: Icon(
                FontAwesomeIcons.arrowLeft,
                size: 25,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('Bookmarked Recipes',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            children: [
              RecipeThumbnail(),
              StreamBuilder(
                  stream: firestoreDbMethod,
                  builder: (
                    context,
                    snapshot,
                  ) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    return Expanded(
                      child: ListView.builder(
                          itemCount: 1, //snapshot.data.docs.length,
                          itemBuilder: (context, int index) {
                            return MethodCard(
                              snapshot: snapshot.data,
                              index:
                                  0, //changes depending on what recipe is selected
                            );
                          }),
                    );
                  }),
            ],
          ),
        ));
  }

  Future _getImageURL() async {
    //ref string will change so the parameter will be the jpg ID (maybe)
    String downloadURL = await storage.ref('prawnpasta.jpg').getDownloadURL();
    return downloadURL;
  }
}

class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.favorite,
        color: _isFavorite ? Colors.black : Colors.red,
      ),
      onPressed: () {
        setState(() {
          _isFavorite = !_isFavorite;
        });
      },
    );
  }
}
