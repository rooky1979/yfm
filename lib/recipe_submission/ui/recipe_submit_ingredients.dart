import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youth_food_movement/colours/hex_colours.dart';
import 'package:youth_food_movement/homepage/profile_page.dart';
import 'package:youth_food_movement/recipe_submission/network/db_control.dart';
import 'package:youth_food_movement/recipe_submission/ui/recipe_submit_method.dart';

class IngredientsSubmission extends StatefulWidget {
  @override
  _IngredientsSubmissionState createState() => _IngredientsSubmissionState();
}

class _IngredientsSubmissionState extends State<IngredientsSubmission> {
  //value used for measurement selection
  var _measurementValue;
  //refactored textstyle used buttons/textfields
  var whiteText =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  var blackText =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
  //refactored dividers for continual use
  var divider = Divider(
    height: 10,
    thickness: 3,
    indent: 20,
    endIndent: 20,
    color: ceruleanCrayola,
  );
//snackbar if any of the fields are empty and the user tries to add ingredients
//or if the user tries to go to the next page with nothing submitted
  var snackbar = SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: Color(0xFFe62d11),
      content: Text("Please fill out all fields before proceeding",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          )));
  //text controller for the textfield
  TextEditingController ingredientController;
  TextEditingController amountController;
  //string to hold the measurement unit
  String unit = '';
//colours for the fields
  Color lightPurple = Color(0xFFe62d1);
  Color darkPurple = Color(0xFF7a243e);
  @override
  void initState() {
    super.initState();
    ingredientController = TextEditingController();
    amountController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: onyx,
        resizeToAvoidBottomInset: false,
        //appbar with title and back arrow
        appBar: AppBar(
          flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[turquoiseGreen, greenSheen])),
        ),
          leading: IconButton(
              icon: Icon(
                FontAwesomeIcons.arrowLeft,
                size: 25,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('Add the ingredients!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              )),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                //textfield for name of ingredient
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  //text field to enter the name of the recipe
                  child: TextField(
                    //need to send to DB refer to comment section
                    controller: ingredientController,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Ingredient',
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                      fillColor: ceruleanCrayola,
                      filled: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: celadonBlue, width: 2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: celadonBlue, width: 3),
                      ),
                    ),
                  ),
                ),
                //textbox for measurement entries
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 30, bottom: 8.0),
                      child: Text(
                        'Measurements:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
                //textfield
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: TextField(
                        controller: amountController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9\.]")),
                        ],
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: true,
                            decimal: true), //only shows a numerical keyboard
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Enter amount',
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          fillColor: ceruleanCrayola,
                          filled: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: celadonBlue, width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: celadonBlue, width: 3),
                          ),
                        ),
                      ),
                    ),
                    //dropdown menu for the measurement unit
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      //create a drop down menu and remove the underline
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 13.0,
                          right: 13.0,
                        ),
                        child: DropdownButtonFormField(
                          iconEnabledColor: Colors.blue[900],
                          isExpanded: true,
                          decoration: InputDecoration(
                            //enabledBorder: InputBorder.none,
                            labelText: 'Unit',
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            fillColor: ceruleanCrayola,
                            filled: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: celadonBlue, width: 2),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: celadonBlue, width: 3),
                            ),
                          ),
                          //dropdown menu labels
                          dropdownColor: celadonBlue,
                          value: _measurementValue,
                          items: [
                            "",
                            "tinned",
                            "cloves",
                            "to taste",
                            "small",
                            "medium",
                            "large",
                            "pinch",
                            "tsp",
                            "tbsp",
                            "g",
                            "kg",
                            "mL",
                            "L"
                          ]
                              .map((label) => DropdownMenuItem(
                                    child: Center(
                                      child: Text(
                                        label,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    value: label,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            unit = value;
                            setState(() => _measurementValue = value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                            child: Text(
                              'PREVIOUS',
                              style: TextStyle(
                                color: greenSheen,
                                fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              setState(() {});
                              if (DBControl.ingredients.isNotEmpty) {
                                DBControl.ingredients.removeLast();
                              } else {} //remove last ingredient from the list
                              //if list is empty, do nothing
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: greenSheen),
                            child: Text(
                              'NEXT',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              if (ingredientController.text.isEmpty ||
                                  amountController.text.isEmpty ||
                                  _measurementValue == null) {
                                //snackbar shown if any of the fields are empty
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              } else {
                                //if not empty, add to the list
                                setState(() {});
                                DBControl.ingredients.add(
                                    amountController.text +
                                        ' ' +
                                        unit +
                                        ' ' +
                                        ingredientController.text);
                                amountController.clear();
                                ingredientController.clear();
                                _measurementValue = null;
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                divider,
                //List to show what has been added so far
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 30, bottom: 8.0),
                            child: Text(
                              'Added so far:',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: DBControl.ingredients.length,
                            itemBuilder: (context, int index) {
                              return Column(
                                children: [
                                  ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: celadonBlue,
                                        radius: 10,
                                      ),
                                      title: Text(
                                        DBControl.ingredients[index].toString(),
                                        style: TextStyle(
                                          color: white,
                                        ),
                                      )),
                                  Divider(
                                    height: 10,
                                    thickness: 2,
                                    indent: 40,
                                    endIndent: 20,
                                    color: ceruleanCrayola,
                                  ),
                                ],
                              );
                            }),
                      )
                    ],
                  ),
                ),
                //cancel and done buttons to move to next page or go to previous page
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: greenSheen
                            ),
                            child: Text(
                              'DONE',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              if (DBControl.ingredients.isEmpty) {
                                //snackbar shown if any of the fields are empty
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              } else {
                                //Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MethodSubmission()));
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                            child: Text(
                              'CANCEL',
                              style: TextStyle(
                                color: greenSheen,
                                fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              //clears the controllers and variables
                              amountController.clear();
                              ingredientController.clear();
                              _measurementValue = null;
                              DBControl.clearDBVariables();
                              DBControl.popPage(2, context);
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ProfilePage());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
