import 'package:youth_food_movement/recipe/ui/recipe_method_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class Method extends StatelessWidget {
  final String recipeID;
  Method([this.recipeID]);

  @override
  Widget build(BuildContext context) {
    var firestoreDbMethod = FirebaseFirestore.instance
        .collection('recipe')
        .doc('$recipeID')
        .collection('method')
        .snapshots();
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
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
