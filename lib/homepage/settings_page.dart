import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:youth_food_movement/login/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//a temp page to hold the user information and to display all the information
//related to the user that they may want to see/edit

@override
Widget build(BuildContext context) {
  return Center();
}

// ignore: must_be_immutable
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Card(
          child: Container(
            width: 200.0,
            height: 200.0,
            decoration: new BoxDecoration(),
            child: Icon(FontAwesomeIcons.plusCircle, //comments button
                size: 40,
                color: Colors.red),
          ),
        ),
        Card(),
        Card(),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return Colors.red;
                },
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              context.read<AuthenticationService>().signOut();
            },
            child: Text("Sign Out")),
      ])),
    );
  }
}

class FirebaseApp {}
