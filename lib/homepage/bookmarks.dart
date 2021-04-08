import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youth_food_movement/recipe/ui/recipe_controls_page.dart';
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
          padding: const EdgeInsets.only(top: 20),
          child: Column(children: [
            BookmarkedRecipeThumbnail(),
          ]),
        ));
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

class BookmarkedRecipeThumbnail extends StatelessWidget {
  //wrap it in inkwell?
//declare and instantiate the firebase storage bucket
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: 'gs://youth-food-movement.appspot.com');

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.25,
          //get the image URL
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
                  ));
                }
              }),
        ),
        FavoriteButton()
      ],
    );
  }

//method to get the image URL
  Future _getImageURL() async {
    //ref string will change so the parameter will be the jpg ID (maybe)
    String downloadURL = await storage.ref('prawnpasta.jpg').getDownloadURL();
    return downloadURL;
  }
}
