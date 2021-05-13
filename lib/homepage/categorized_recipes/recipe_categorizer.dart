/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youth_food_movement/recipe/ui/test_grid_tile.dart';

class BeefRecipe extends StatefulWidget {
  @override
  _BeefRecipe createState() => _BeefRecipe();
}

class _BeefRecipe extends State<BeefRecipe> {
  var firestoreDb = FirebaseFirestore.instance.collection('recipe').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: new Color(0xFFf0f1eb),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(
            height: 200.0,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // ignore: unnecessary_statements
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: 200.0,
                      child: Container(
                        height: 50.0,
                        color: Colors.red,
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(right: 5.0)),
                              Text(
                                'Beef',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                              StreamBuilder(
                                stream: firestoreDb,
                                builder: (
                                  context,
                                  snapshot,
                                ) {
                                  if (!snapshot.hasData)
                                    return CircularProgressIndicator();
                                  return GridView.builder(
                                    itemCount: snapshot.data.docs.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 1),
                                    itemBuilder: (context, int index) {
                                      return GestureDetector(
                                        child: Card(
                                          child: TestGridTile(
                                            snapshot: snapshot.data,
                                            index: index,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: new Color(0xFFf0f1eb),
      body:  ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: <Widget>[
           SizedBox(height: 20.0),
           Container(
            child:  ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return  Column(
                  children: <Widget>[
                     Container(
                      height: 50.0,
                      color: Colors.red,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                           Padding(
                              padding: const EdgeInsets.only(right: 5.0)),
                           Text(
                            'Beef',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                     Container(
                      height: 150.0,
                      child:  ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return  Card(
                            elevation: 5.0,
                            child:  Row(
                              children: [
                                RecipeThumbnail(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                     SizedBox(height: 20.0),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/
