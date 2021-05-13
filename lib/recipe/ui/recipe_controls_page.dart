import 'package:youth_food_movement/recipe/ui/ingredients_page.dart';
import 'package:youth_food_movement/comments/recipe_page_comments.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youth_food_movement/recipe/ui/method_page.dart';
import 'package:youth_food_movement/homepage/test_grid_tile.dart';

import 'package:firebase_auth/firebase_auth.dart';

class RecipeControlsPage extends StatefulWidget {
  @override
  _RecipeControlsPageState createState() => _RecipeControlsPageState();
}

class _RecipeControlsPageState extends State<RecipeControlsPage> {
  @override
  Widget build(BuildContext context) {
    //main page setup
    return Scaffold(
        backgroundColor: new Color(0xFFebe7d2),
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
          color: new Color(0xFFebe7d2),
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
                      color: new Color(0xFFebe7d2),
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
              color: new Color(0xFFe62d11),
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: new Color(0xFFe62d11),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RawMaterialButton(
                  padding: EdgeInsets.all(10), //ingredients button
                  fillColor: new Color(0xFFebe7d2),
                  shape: CircleBorder(),
                  child: Icon(
                    FontAwesomeIcons.info,
                    size: 40,
                    color: new Color(0xFFe62d11),
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
                  fillColor: new Color(0xFFebe7d2),
                  shape: CircleBorder(),
                  child: Icon(
                    FontAwesomeIcons.book,
                    size: 40,
                    color: new Color(0xFFe62d11),
                  ),
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
                  fillColor: new Color(0xFFebe7d2),
                  shape: CircleBorder(),
                  child: Icon(
                    FontAwesomeIcons.comments, //comments button
                    size: 40,
                    color: new Color(0xFFe62d11),
                  ),
                  onPressed: () => {
                        //pops any page currently loaded off the stack and pushes the required page onto the stack
                        Navigator.pop(context),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => CommentBoard(
                                      recipeID:
                                          TestGridTile.idNumber.toString(),
                                    )))
                      }),
            ],
          ),
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
          color: new Color(0xFFebe7d2),
        ),
        FutureBuilder(
            future: _getLiked(),
            builder: (context, snapshot) {
              widget.isLiked = snapshot.data;
              if (snapshot.hasData) {
                return IconButton(
                    icon: Icon(Icons.favorite_rounded, //comments button
                        size: 50,
                        color: widget.isLiked
                            ? new Color(0xFFe62d11)
                            : Colors.grey),
                    onPressed: () {
                      if (widget.isLiked) {
                        setState(() {
                          widget.isLiked = !widget.isLiked;
                          debugPrint(widget.isLiked.toString() +
                              "This has been removed from favourites: " +
                              TestGridTile.idNumber.toString());
                          _getUserDocIdForDelete(TestGridTile.idNumber);
                        });
                      } else if (!widget.isLiked) {
                        setState(() {
                          widget.isLiked = !widget.isLiked;
                          debugPrint(widget.isLiked.toString() +
                              "This has been removed from favourites: " +
                              TestGridTile.idNumber.toString());
                          _getUserDocIdForAdd(TestGridTile.idNumber);
                        });
                      }
                    });
                // } else if (widget.isLiked == false) {
                //   return IconButton(
                //       icon: Icon(
                //         Icons.favorite_outline_rounded,
                //         size: 50,
                //         color: Colors.red,
                //       ),
                //       onPressed: () {
                //         setState(() {
                //           //if array contains recipeID, remove
                //           widget.isLiked = !widget.isLiked;
                //           debugPrint(widget.isLiked.toString() +
                //               "This has been Added to favourites: " +
                //               TestGridTile.idNumber.toString());
                //           _getUserDocIdForAdd(TestGridTile.idNumber);
                //         });
                //         setState(() {});
                //       });
                // }
              } else {
                return CircularProgressIndicator();
              }
            }),
      ],
    );

    //   if (!_isFavorite) {
    //     return IconButton(
    //         icon: Icon(
    //           Icons.favorite_outline_rounded, //comments button
    //           size: 50,
    //           color: Colors.red,
    //         ),
    //         onPressed: () {
    //           setState(() {
    //             _isFavorite = !_isFavorite;
    //             //add recipe ID to favourites array
    //             _getUserDocIdForAdd(TestGridTile.idNumber.toString());
    //           });
    //         });
    //   } else {
    //     return IconButton(
    //         icon: Icon(
    //           Icons.favorite_rounded,
    //           size: 50,
    //           color: Colors.red,
    //         ),
    //         onPressed: () {
    //           setState(() {
    //             _isFavorite = !_isFavorite;
    //             //if array contains recipeID, remove
    //             _getUserDocIdForDelete(TestGridTile.idNumber);
    //           });
    //         });
  }
}

//helper method to add the recipe ID to the firestore favourites array
void _addFavouriteToDB(String recipeIdNumber, String id) async {
  //instantiate a local list to hold temp ID
  List recipes = [recipeIdNumber];

  //add the temp array to the firestore
  await FirebaseFirestore.instance
      .collection('users')
      .doc(id)
      .update({'favourites': FieldValue.arrayUnion(recipes)});
  //clear the temp array
  recipes.clear();
}

void _getUserDocIdForAdd(String recipeIdNumber) async {
  String id;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  await FirebaseFirestore.instance
      .collection('users') // Users table in firestore
      .where('uid',
          isEqualTo: _firebaseAuth.currentUser
              .uid) //first uid is the user ID of in the users table (not document id)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      id = doc.id;
      debugPrint(id);
      _addFavouriteToDB(recipeIdNumber, id);
    });
  });
}

void _getUserDocIdForDelete(String recipeIdNumber) async {
  String id;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  await FirebaseFirestore.instance
      .collection('users') // Users table in firestore
      .where('uid',
          isEqualTo: _firebaseAuth.currentUser
              .uid) //first uid is the user ID of in the users table (not document id)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      id = doc.id;
      debugPrint(id);
      _removeFavouriteFromDB(recipeIdNumber, id);
    });
  });
}

//helper method to add the recipe ID to the firestore favourites array
void _removeFavouriteFromDB(String recipeIdNumber, String id) async {
  //instantiate a local list to hold temp ID
  List recipes = [recipeIdNumber];

  //add the temp array to the firestore
  await FirebaseFirestore.instance
      .collection('users')
      .doc(id)
      .update({'favourites': FieldValue.arrayRemove(recipes)});
  //clear the temp array
  recipes.clear();
}

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
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      recipes = doc['favourites'];
      if (recipes.contains(TestGridTile.idNumber.toString())) {
        liked = true;
      }
    });
  });

  return liked;
}

//method to check if the recipe ID is in the users array
_checkRecipeFavourited(String idNumber) async {
  var firestoreDB = FirebaseFirestore.instance
      .collection('users')
      .doc('0dT614naJKZgbjRZCGMj')
      .snapshots();

  List recipes = [];
  bool checkMatch = false;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  await FirebaseFirestore.instance
      .collection('users') // Users table in firestore
      .where('uid',
          isEqualTo: _firebaseAuth.currentUser
              .uid) //first uid is the user ID of in the users table (not document id)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      debugPrint(doc['favourites'].toString() + "again");
      recipes.add(doc['favourites']);
      debugPrint(recipes.toString() + "Saved local");
      return true;
    });
  });

  if (recipes.contains(idNumber)) {
    // ignore: unnecessary_statements
    checkMatch == true;
  }

  return checkMatch;
}
