import 'package:youth_food_movement/recipe/ui/ingredients_page.dart';
import 'package:youth_food_movement/recipe/ui/recipe_page_comments.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youth_food_movement/recipe/ui/method_page.dart';
import 'package:youth_food_movement/recipe/ui/test_grid_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeControlsPage extends StatefulWidget {
  @override
  _RecipeControlsPageState createState() => _RecipeControlsPageState();
}

class _RecipeControlsPageState extends State<RecipeControlsPage> {
  @override
  Widget build(BuildContext context) {
    //main page setup
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
          RecipeThumbnail(),
          RecipeButtons(),
        ],
      ),
    ));
  }
}

//displays the thumbnail from firebase storage
class RecipeThumbnail extends StatelessWidget {
//declare and instantiate the firebase storage bucket
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: 'gs://youth-food-movement.appspot.com');

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          //get the image URL
          child: FutureBuilder(
              future: _getImageURL(), //helper method
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //return the image and make it cover the container
                  return GestureDetector(
                    child: Image.network(
                      snapshot.data,
                      fit: BoxFit.cover,
                    ),
                    onTap: () {
                      //onTap makes the image go full size
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return GestureDetector(
                          child: Center(
                            child: Image.network(
                              snapshot.data,
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () => Navigator.pop(
                              context), //onTap the image pops off and returns to controls page
                        );
                      }));
                    },
                  );
                } else {
                  return Container(
                      //while image is loading, display the circular indicator
                      child: Center(
                    child: CircularProgressIndicator(),
                  ));
                }
              }),
        ),
        //back arrow
        IconButton(
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              size: 30,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        Positioned(
            right: 10.0,
            bottom: 10.0,
            child:
                Favourites() /* IconButton(
              //alignment: Alignment.bottomRight,
              icon: Icon(
                Icons.favorite,
                size: 40,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.pop(context);
              }), */
            ),
      ],
    );
  }

//ansynchronous method to get the image URL
  Future _getImageURL() async {
    String downloadURL = await storage
        .ref('recipe_images/' + TestGridTile.idNumber.toString())
        .getDownloadURL();
    return downloadURL;
  }
}

//creates the buttons on the screen to take the user to each section
// ignore: must_be_immutable
class RecipeButtons extends StatelessWidget {
  String docID = TestGridTile.idNumber.toString();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, left: 3.0, right: 3.0),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 90,
        //color: Colors.red[400],
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.red[400],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RawMaterialButton(
                  padding: EdgeInsets.all(10), //ingredients button
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  child: Icon(
                    FontAwesomeIcons.info,
                    size: 40,
                    color: Colors.red,
                  ),
                  onPressed: () => {
                        //pops any page currently loaded off the stack and pushes the required page onto the stack
                        Navigator.pop(context),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    IngredientsPage(
                                        TestGridTile.idNumber.toString())))
                      }),
              RawMaterialButton(
                  // recipe method button
                  padding: EdgeInsets.all(10),
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  child:
                      Icon(FontAwesomeIcons.book, size: 40, color: Colors.red),
                  onPressed: () => {
                        //pops any page currently loaded off the stack and pushes the required page onto the stack
                        Navigator.pop(context),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Method(TestGridTile.idNumber.toString())))
                      }),
              RawMaterialButton(
                  padding: EdgeInsets.all(11),
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  child: Icon(FontAwesomeIcons.comments, //comments button
                      size: 40,
                      color: Colors.red),
                  onPressed: () => {
                        //pops any page currently loaded off the stack and pushes the required page onto the stack
                        Navigator.pop(context),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CommentBoard()))
                      }),
            ],
          ),
        ),
      ),
    );
  }
}

//favourites button that toggles solid for favourited and outline for unfavourited
class Favourites extends StatefulWidget {
  var firestoreDb = FirebaseFirestore.instance
      .collection('recipe')
      .doc('0ZWT2Ljrk8SS5wmh7zwD')
      .snapshots();
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    if (!_isFavorite) {
      return IconButton(
          icon: Icon(
            Icons.favorite_outline_rounded, //comments button
            size: 50,
            color: Colors.red,
          ),
          onPressed: () {
            setState(() {
              _isFavorite = !_isFavorite;
              //add recipe ID to favourites array
              _favouriteToDB(TestGridTile.idNumber.toString());
            });
          });
    } else {
      return IconButton(
          icon: Icon(
            Icons.favorite_rounded,
            size: 50,
            color: Colors.red,
          ),
          onPressed: () {
            setState(() {
              _isFavorite = !_isFavorite;
              //if array contains recipeID, remove
              _removeFavouriteFromDB(TestGridTile.idNumber);
            });
          });
    }
  }
//helper method to add the recipe ID to the firestore favourites array
  void _favouriteToDB(String idNumber) async {
    //instantiate a local list to hold temp ID
    List recipes = [];
    //add the idNumber to the temp array
    recipes.add(idNumber);
    //add the temp array to the firestore
    await FirebaseFirestore.instance
        .collection('Users')
        .doc('0ZWT2Ljrk8SS5wmh7zwD')
        .update({'favourites': FieldValue.arrayUnion(recipes)});
        //clear the temp array
        recipes.clear();
  }
//helper method to add the recipe ID to the firestore favourites array
  void _removeFavouriteFromDB(String idNumber) async {
        //instantiate a local list to hold temp ID
    List recipes = [];
        //add the idNumber to the temp array
    recipes.add(idNumber);
        //add the temp array to the firestore
    await FirebaseFirestore.instance
        .collection('Users')
        .doc('0ZWT2Ljrk8SS5wmh7zwD')
        .update({'favourites': FieldValue.arrayRemove(recipes)});
        //clear the temp array
        recipes.clear();
  }
  
}
