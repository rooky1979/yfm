import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    color: Colors.black,
  );
//snackbar if any of the fields are empty and the user tries to add ingredients
//or if the user tries to go to the next page with nothing submitted
  var snackbar = SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: Colors.blue[600],
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
  //list to hold ingredient strings
  //List ingredients = [];
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
        resizeToAvoidBottomInset: false,
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
          title: Text('Add the ingredients!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: 'Ingredient',
                      labelStyle: whiteText,
                      fillColor: Colors.red[400],
                      filled: true,
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 3.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 3.0),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
                divider,
                //textbox for measurement entries
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 30, bottom: 8.0),
                      child: Text(
                        'Measurements:',
                        style: blackText,
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
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9\.]")),],
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: true,
                            decimal: true), //only shows a numerical keyboard
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          labelText: 'Enter amount',
                          labelStyle: whiteText,
                          fillColor: Colors.red[400],
                          filled: true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 3.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 3.0),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                    //dropdown menu for the measurement unit
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.red[400],
                      ),
                      //create a drop down menu and remove the underline
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 13.0,
                          right: 13.0,
                        ),
                        child: DropdownButtonFormField(
                          iconEnabledColor: Colors.white,
                          isExpanded: true,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            labelText: 'Unit',
                            labelStyle: whiteText,
                          ),
                          //dropdown menu labels
                          dropdownColor: Colors.red[300],
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
                                        style: whiteText,
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
                  padding: const EdgeInsets.only(top: 13.0),
                  child: divider,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                          child: Text(
                            'Previous',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
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
                              primary: Colors.red[100]),
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
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
                              DBControl.ingredients.add(amountController.text +
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
                              style: blackText,
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
                                      backgroundColor: Colors.red,
                                      radius: 10,
                                    ),
                                    title: Text(
                                        DBControl.ingredients[index].toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Divider(
                                    height: 10,
                                    thickness: 2,
                                    indent: 40,
                                    endIndent: 20,
                                    color: Colors.red[200],
                                  ),
                                ],
                              );
                            }),
                      )
                    ],
                  ),
                ),
                divider,
                //cancel and done buttons to move to next page or go to previous page
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
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
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          child: Text(
                            'Done',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
