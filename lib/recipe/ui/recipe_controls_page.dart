import 'package:youth_food_movement/colours/hex_colours.dart';
import 'package:youth_food_movement/recipe/ui/ingredients_page.dart';
import 'package:youth_food_movement/comments/recipe_page_comments.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youth_food_movement/recipe/ui/method_page.dart';
import 'package:youth_food_movement/homepage/homepage_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecipeControlsPage extends StatefulWidget {
  @override
  _RecipeControlsPageState createState() => _RecipeControlsPageState();
}

class _RecipeControlsPageState extends State<RecipeControlsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            RecipeThumbnail(),
            RecipeButtons(),
          ],
        ),
      ),
    );
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
          color: linen,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
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
                        },
                      ),
                    );
                  },
                );
              } else {
                return Container(
                  color: linen,
                  //while image is loading, display the circular indicator
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
        //back arrow
        IconButton(
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              size: 30,
              color: orangeRed,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        Positioned(
          right: 10.0,
          bottom: 10.0,
          child: Favourites(),
        ),
      ],
    );
  }

//ansynchronous method to get the image URL
  Future _getImageURL() async {
    String downloadURL = await storage
        .ref('recipe_images/' + HomepageTile.idNumber.toString())
        .getDownloadURL();
    return downloadURL;
  }
}

//creates the buttons on the screen to take the user to each section
// ignore: must_be_immutable
class RecipeButtons extends StatelessWidget {
  String docID = HomepageTile.idNumber.toString();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, left: 3.0, right: 3.0),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: darkPurple,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RawMaterialButton(
              padding: EdgeInsets.all(10), //ingredients button
              fillColor: linen,
              shape: CircleBorder(),
              child: Icon(
                FontAwesomeIcons.info,
                size: 20,
                color: darkPurple,
              ),
              onPressed: () => {
                //pops any page currently loaded off the stack and pushes the required page onto the stack
                Navigator.pop(context),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => IngredientsPage(
                      HomepageTile.idNumber.toString(),
                    ),
                  ),
                )
              },
            ),
            RawMaterialButton(
              // recipe method button
              padding: EdgeInsets.all(10),
              fillColor: linen,
              shape: CircleBorder(),
              child: Icon(
                FontAwesomeIcons.book,
                size: 20,
                color: darkPurple,
              ),
              onPressed: () => {
                //pops any page currently loaded off the stack and pushes the required page onto the stack
                Navigator.pop(context),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Method(
                      HomepageTile.idNumber.toString(),
                    ),
                  ),
                )
              },
            ),
            RawMaterialButton(
              padding: EdgeInsets.all(11),
              fillColor: linen,
              shape: CircleBorder(),
              child: Icon(
                FontAwesomeIcons.comments, //comments button
                size: 20,
                color: darkPurple,
              ),
              onPressed: () => {
                //pops any page currently loaded off the stack and pushes the required page onto the stack
                Navigator.pop(context),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => CommentBoard(
                      recipeID: HomepageTile.idNumber.toString(),
                    ),
                  ),
                )
              },
            ),
          ],
        ),
      ),
    );
  }
}

//favourites button that toggles solid for favourited and outline for unfavourited
// ignore: must_be_immutable
class Favourites extends StatefulWidget {
  bool isLiked;

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  //bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: linen,
        ),
        FutureBuilder(
          future: _getLiked(),
          builder: (context, snapshot) {
            widget.isLiked = snapshot.data;
            if (snapshot.hasData) {
              return IconButton(
                icon: Icon(Icons.favorite_rounded, //comments button
                    size: 50,
                    color: widget.isLiked ? orangeRed : grey),
                onPressed: () {
                  if (widget.isLiked) {
                    setState(
                      () {
                        widget.isLiked = !widget.isLiked;
                        debugPrint(
                          widget.isLiked.toString() +
                              "This has been removed from favourites: " +
                              HomepageTile.idNumber.toString(),
                        );
                        _getUserDocIdForDelete(HomepageTile.idNumber);
                      },
                    );
                  } else if (!widget.isLiked) {
                    setState(
                      () {
                        widget.isLiked = !widget.isLiked;
                        debugPrint(widget.isLiked.toString() +
                            "This has been removed from favourites: " +
                            HomepageTile.idNumber.toString());
                        _getUserDocIdForAdd(HomepageTile.idNumber);
                      },
                    );
                  }
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}

//helper method to add the recipe ID to the firestore favourites array
void _addFavouriteToDB(String recipeIdNumber, String id) async {
  //instantiate a local list to hold temp ID
  List recipes = [recipeIdNumber];

  //add the temp array to the firestore
  await FirebaseFirestore.instance.collection('users').doc(id).update(
    {
      'favourites': FieldValue.arrayUnion(recipes),
      'num_favourites': FieldValue.increment(1)
    },
  );
  //clear the temp array
  recipes.clear();
}

/*
    This method gets the current user and recipe ID and feeds it to
    the method for adding a recipe to the database
 */
void _getUserDocIdForAdd(String recipeIdNumber) async {
  String id;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  await FirebaseFirestore.instance
      .collection('users') // Users table in firestore
      .where('uid',
          isEqualTo: _firebaseAuth.currentUser
              .uid) //first uid is the user ID of in the users table (not document id)
      .get()
      .then(
    (QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach(
        (doc) {
          id = doc.id;
          debugPrint(id);
          _addFavouriteToDB(recipeIdNumber, id);
        },
      );
    },
  );
}

/*
    This method gets the current user and recipe ID and feeds it to
    the method for removing a recipe from the database
 */
void _getUserDocIdForDelete(String recipeIdNumber) async {
  String id;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  await FirebaseFirestore.instance
      .collection('users') // Users table in firestore
      .where('uid', isEqualTo: _firebaseAuth.currentUser.uid)
      .get()
      .then(
    (QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach(
        (doc) {
          id = doc.id;
          debugPrint(id);
          _removeFavouriteFromDB(recipeIdNumber, id);
        },
      );
    },
  );
}

//helper method to remove the recipe ID from the firestore favourites array
void _removeFavouriteFromDB(String recipeIdNumber, String id) async {
  //instantiate a local list to hold temp ID
  List recipes = [recipeIdNumber];

  //add the temp array to the firestore
  await FirebaseFirestore.instance.collection('users').doc(id).update(
    {
      'favourites': FieldValue.arrayRemove(recipes),
      'num_favourites': FieldValue.increment(-1)
    },
  );
  //clear the temp array
  recipes.clear();
}

/*
 * This method checks if the open recipe has been liked by the user
 * and returns true or false.
 */
Future _getLiked() async {
  bool liked = false;
  List recipes = [];
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  await FirebaseFirestore.instance
      .collection('users') // Users table in firestore
      .where('uid',
          isEqualTo: _firebaseAuth.currentUser
              .uid) //first uid is the user ID of in the users table (not document id)
      .get()
      .then(
    (QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach(
        (doc) {
          recipes = doc['favourites'];
          if (recipes.contains(HomepageTile.idNumber.toString())) {
            liked = true;
          }
        },
      );
    },
  );

  return liked;
}
