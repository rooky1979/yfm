import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'bookmarked_recipe_control.dart';

// ignore: must_be_immutable
class BookmarkedRecipeThumbnail extends StatelessWidget {
  var firestoreDbMethod =
      FirebaseFirestore.instance.collection('method').snapshots();
  @override
  Widget build(BuildContext context) {
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
                        return BookmarkedCard(
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
