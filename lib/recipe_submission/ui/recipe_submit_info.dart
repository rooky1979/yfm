import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InformationSubmission extends StatefulWidget {
  @override
  _InformationSubmissionState createState() => _InformationSubmissionState();
}
//form for the recipe name, servings, preptime, allergies, category and proteins
class _InformationSubmissionState extends State<InformationSubmission> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar with title and back arrow
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              size: 25,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Submit your recipe!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
      ),
      //container for the recipe title text field
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextField(
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                fillColor: Colors.red[400],
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 3.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 3.0),
                  borderRadius: BorderRadius.circular(15)
                ),
                hintText: 'What is your recipe called?',
                hintStyle: TextStyle(fontSize: 20, 
                fontWeight: FontWeight.bold,
                color: Colors.white)
              ),
            ),
          ),
          //number picker for the user to enter the number of servings

          //preptime selectors

          //allergies

          //category

          //proteins

          //cancel and next buttons
        ]),
      ),
    );
  }
}
