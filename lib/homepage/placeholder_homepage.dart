import 'package:flutter/material.dart';
import 'package:youth_food_movement/recipe/ui/recipe_controls_page.dart';
import 'package:youth_food_movement/homepage/profile_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon: Icon(Icons.account_circle),
          ),
          InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipeControlsPage()));
            },
            child: const SizedBox(
              width: 300,
              height: 100,
              child: Text('Sample Text 1'),
            ),
          ),
          InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipeControlsPage()));
            },
            child: const SizedBox(
              width: 300,
              height: 100,
              child: Text('Sample text 2'),
            ),
          ),
          InkWell(
            splashColor: Colors.red.withAlpha(30),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipeControlsPage()));
            },
            child: const SizedBox(
              width: 300,
              height: 100,
              child: Text('Sample text 3'),
            ),
          ),
        ]),
      ),
    );
  }
}
