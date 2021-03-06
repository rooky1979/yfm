import 'package:youth_food_movement/colours/hex_colours.dart';
import 'package:youth_food_movement/recipe/ui/recipe_controls_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'recipe_info_card.dart';

// ignore: must_be_immutable
class IngredientsPage extends StatelessWidget {
  final String recipeID;
  IngredientsPage([this.recipeID]);

  @override
  Widget build(BuildContext context) {
    var firestoreDb = FirebaseFirestore.instance
        .collection('recipe')
        .doc('$recipeID')
        .collection('ingredients')
        .snapshots();

    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            RecipeThumbnail(),
            RecipeButtons(),
            StreamBuilder(
              stream: firestoreDb,
              builder: (
                context,
                snapshot,
              ) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, int index) {
                      return RecipeInformationCard(
                        snapshot: snapshot.data,
                        index:
                            index, //this changes depending on what recipe is selected
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
