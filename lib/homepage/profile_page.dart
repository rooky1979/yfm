import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youth_food_movement/Submission/submission_temp.dart';
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Card(
              child: Container(
                width: 125.0,
                height: 125.0,
                decoration: new BoxDecoration(),
                child: new Text('THIS IS THE PROFILE PAGE'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingPage()),
                      );
                    },
                    icon: Icon(Icons.settings),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          ;
                        },
                        icon: Icon(Icons.public),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubmissionPage()),
                          );
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                )
              ],
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
