import 'dart:html';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youth_food_movement/login/authentication_service.dart';
import 'package:youth_food_movement/recipe/ui/recipe_controls_page.dart';
import 'package:youth_food_movement/settings/settings_page.dart';

@override
Widget build(BuildContext context) {
  return Center();
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Container(
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5.0),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.zero)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Recipe",
                      hintStyle: TextStyle(color: Colors.white),
                      icon: Icon(Icons.list, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecipeControlsPage()),
                          );
                        },
                        icon: Icon(Icons.search),
                      ),
                    ],
                  ),
                )
              ],
            )),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingPage()),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
            Card(
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: new BoxDecoration(),
                child: new Text('THIS IS THE PROFILE PAGE'),
              ),
            ),
            Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      flex: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search Recipe",
                                hintStyle: TextStyle(color: Colors.white),
                                icon: Icon(Icons.list, color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RecipeControlsPage()),
                                    );
                                  },
                                  icon: Icon(Icons.search),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RecipeControlsPage()),
                                    );
                                  },
                                  icon: Icon(Icons.search),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RecipeControlsPage()),
                                    );
                                  },
                                  icon: Icon(Icons.search),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Return to Homepage'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<AuthenticationService>().signOut();
                },
                child: Text("Sign Out")),
          ])),
    );
  }
}
