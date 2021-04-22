import 'package:youth_food_movement/recipe/ui/recipe_method_card.dart';
import 'package:youth_food_movement/recipe/ui/recipe_controls_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class Method extends StatelessWidget {
  Method([this.recipeID]);
  final String recipeID;
  var firestoreDbMethod =
<<<<<<< HEAD
      FirebaseFirestore.instance.collection('method').snapshots();

=======
      FirebaseFirestore.instance.collection('recipe').doc('BZrIwfHcVtgrCRK74nWa').collection('method').snapshots();
>>>>>>> 118181220700cbed8f6f821c6fd6338236dd304e
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
          RecipeThumbnail(),
          RecipeButtons(recipeID: recipeID),
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
}
