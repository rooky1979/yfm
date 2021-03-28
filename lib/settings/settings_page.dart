import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youth_food_movement/login/authentication_service.dart';
import 'package:youth_food_movement/recipe/ui/recipe_controls_page.dart';

@override
Widget build(BuildContext context) {
  return Center();
}

class SettingPage extends StatelessWidget {
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
                      hintText: "Settings Page",
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
            icon: Icon(Icons.time_to_leave),
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
                child: new Text('Profile Picture!'),
              ),
            ),
            Card(
              child: Container(
                width: 300.0,
                height: 100.0,
                decoration: new BoxDecoration(),
                child: new Text('Profile Description!'),
              ),
            ),
            Card(
              child: Container(
                width: 300.0,
                height: 100.0,
                decoration: new BoxDecoration(),
                child: new Text('About me box'),
              ),
            ),
            Card(
              child: Container(
                width: 300.0,
                height: 100.0,
                decoration: new BoxDecoration(),
                child: new Text('Dietry requirements'),
              ),
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
