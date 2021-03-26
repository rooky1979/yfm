import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numberpicker/numberpicker.dart';

class InformationSubmission extends StatefulWidget {
  @override
  _InformationSubmissionState createState() => _InformationSubmissionState();
}

//form for the recipe name, servings, preptime, allergies, category and proteins
class _InformationSubmissionState extends State<InformationSubmission> {
  //value used for dropdown selection in difficulty selection
  int _difficultyValue;
  //value for servings numberpicker
  int _servingsValue = 0;

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
              //text field for user input
              //need to send to DB refer to comment section
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  fillColor: Colors.red[400],
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.greenAccent, width: 3.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 3.0),
                      borderRadius: BorderRadius.circular(15)),
                  hintText: 'What is your recipe called?',
                  hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
          //dropdown menu for difficulty
          Padding(
            padding: const EdgeInsets.all(13.0),
            //create a container and decorate
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.red[400],
              ),
              //create a drop down menu and remove the underline
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    value: _difficultyValue,
                    iconEnabledColor: Colors.white,
                    isExpanded: true,
                    hint: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text(
                        'Select recipe difficulty',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    dropdownColor: Colors.red[300],
                    items: [
                      DropdownMenuItem(
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Text("Easy",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Text("Medium",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        value: 2,
                      ),
                      DropdownMenuItem(
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Text("Hard",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          value: 3),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _difficultyValue = value;
                      });
                    }),
              ),
            ),
          ),
          //number picker for the user to enter the number of servings
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.red[400],
                    elevation: 11,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                child: Text("How many does the recipe serve?",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () {
                  return Column(
                    children: <Widget>[
                      NumberPicker(
                        value: _servingsValue,
                        minValue: 0,
                        maxValue: 100,
                        onChanged: (value) =>
                            setState(() => _servingsValue = value),
                      ),
                      Text('Current value: $_servingsValue'),
                    ],
                  );
                  // Respond to button press
                },
              ),
            ),
          )
/*           Column(
      children: <Widget>[
        NumberPicker(
          value: _servingsValue,
          minValue: 0,
          maxValue: 100,
          onChanged: (value) => setState(() => _servingsValue = value),
        ),
        Text('Current value: $_servingsValue'),
      ],
    ), */
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
