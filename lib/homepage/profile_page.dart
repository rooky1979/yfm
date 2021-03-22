import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youth_food_movement/login/authentication_service.dart';

@override
Widget build(BuildContext context) {
  return Center();
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
