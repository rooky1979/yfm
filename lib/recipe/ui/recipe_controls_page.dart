import 'package:youth_food_movement/recipe/ui/ingredients_page.dart';
import 'package:youth_food_movement/comments/recipe_page_comments.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youth_food_movement/recipe/ui/method_page.dart';

class RecipeControlsPage extends StatefulWidget {
  @override
  _RecipeControlsPageState createState() => _RecipeControlsPageState();
}

//add in a back button
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
      alignment: Alignment.topLeft,
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return GestureDetector(
                          child: Center(
                            child: Image.network(
                              snapshot.data,
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () => Navigator.pop(context),
                        );
                      }));
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
        IconButton(
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              size: 30,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
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

//creates the buttons on the screen to take the user to each section
class RecipeButtons extends StatefulWidget {
  @override
  _RecipeButtonsState createState() => _RecipeButtonsState();

  final String recipeID;

  const RecipeButtons({Key key, this.recipeID}) : super(key: key);
}

class _RecipeButtonsState extends State<RecipeButtons> {
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
                    FontAwesomeIcons.leaf,
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
                                    IngredientsPage()))
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
                                builder: (BuildContext context) => Method()))
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
                                builder: (BuildContext context) => CommentBoard(
                                      recipeID: widget.recipeID,
                                    )))
                      }),
              Bookybok(),
            ],
          ),
        ),
      ),
    );
  }
}

class Bookybok extends StatefulWidget {
  @override
  _BookybokState createState() => _BookybokState();
}

class _BookybokState extends State<Bookybok> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        padding: EdgeInsets.all(11),
        fillColor: Colors.white,
        shape: CircleBorder(),
        child: Icon(
          FontAwesomeIcons.solidBookmark, //comments button
          size: 40,
          color: _isFavorite ? Colors.red : Colors.black,
        ),
        onPressed: () {
          setState(() {
            _isFavorite = !_isFavorite;
          });
        });
  }
}
