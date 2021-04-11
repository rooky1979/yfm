import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youth_food_movement/recipe/ui/ingredients_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_service.dart';

class PlaceholderHomePage extends StatefulWidget {
  @override
  _PlaceholderHomePageState createState() => _PlaceholderHomePageState();
}

class _PlaceholderHomePageState extends State<PlaceholderHomePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            children: [
              Text("Placeholder Home"),
              Text(_firebaseAuth.currentUser.uid),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IngredientsPage()),
                    );
                  },
                  child: Text("Ingredient page")
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthenticationService>().signOut();
                    },
                  child: Text("Sign Out")
              )
            ]
        ),
      ),
    );
  }
}
