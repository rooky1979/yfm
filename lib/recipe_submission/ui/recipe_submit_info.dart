import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:youth_food_movement/homepage/profile_page.dart';
import 'package:youth_food_movement/recipe_submission/network/db_control.dart';
import 'package:youth_food_movement/recipe_submission/ui/recipe_submit_ingredients.dart';

class InformationSubmission extends StatefulWidget {
  @override
  _InformationSubmissionState createState() => _InformationSubmissionState();
}

//form for the recipe name, servings, preptime, allergies, category and proteins
class _InformationSubmissionState extends State<InformationSubmission> {
  //allergies affected list for the checkbox
  List<dynamic> _allergiesList = [
    {
      "display": "None",
      "value": "None",
    },
    {
      "display": "Lactose",
      "value": "Lactose",
    },
    {
      "display": "Eggs",
      "value": "Eggs",
    },
    {
      "display": "Nuts",
      "value": "Nuts",
    },
    {
      "display": "Soy",
      "value": "Soy",
    },
    {
      "display": "Gluten",
      "value": "Gluten",
    },
    {
      "display": "Shellfish",
      "value": "Shellfish",
    },
    {
      "display": "Fish",
      "value": "Fish",
    },
  ];
  //category for vegan, vegetarian and non-vegetarian
  List<dynamic> categoryList = [
    {
      "display": "Non-Vegetarian",
      "value": "Non-Vegetarian",
    },
    {
      "display": "Vegetarian",
      "value": "Vegetarian",
    },
    {
      "display": "Vegan",
      "value": "Vegan",
    }
  ];
//list for the proteins
  List<dynamic> _proteinList = [
    {
      "display": "Beef",
      "value": "Beef",
    },
    {
      "display": "Poultry",
      "value": "Poultry",
    },
    {
      "display": "Pork",
      "value": "Pork",
    },
    {
      "display": "Dairy",
      "value": "Dairy",
    },
    {
      "display": "Fish",
      "value": "Fish",
    },
    {
      "display": "Shellfish",
      "value": "Shellfish",
    },
    {
      "display": "Pulses",
      "value": "Pulses",
    },
    {
      "display": "Eggs",
      "value": "Eggs",
    },
  ];

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

  @override
  void initState() {
    super.initState();
    DBControl.recipeNameController = TextEditingController();
    DBControl.servingsController = TextEditingController();
    DBControl.hoursController = TextEditingController();
    DBControl.minutesController = TextEditingController();
    DBControl.descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    //refactored textstyle used in buttons/textfields
    var whiteText = TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
    var blackText = TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
    //refactored dividers for continual use
    var divider = Divider(
      height: 10,
      thickness: 3,
      indent: 20,
      endIndent: 20,
      color: Colors.black,
    );
    return Scaffold(
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
              if (DBControl.categoryValue != null) {
                DBControl.categoryValue = null;
              }
              if (DBControl.difficultyValue != null) {
                DBControl.difficultyValue = null;
              }
              DBControl.clearDBVariables();
              Navigator.pop(context);
            }),
        title: Text('Submit your recipe!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
      ),
      //container to hold the column
      body: SingleChildScrollView(
        //makes the view scrollable
        child: FittedBox(
          child: Container(
            width: MediaQuery.of(context).size.width,
            //column to hold the all the user options
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(13.0),
                //text field to enter the name of the recipe
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: DBControl.recipeNameController,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: 'What is the name of your recipe?',
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
              Padding(
                padding: const EdgeInsets.all(13.0),
                //text field to enter the name of the recipe
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: DBControl.descriptionController,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: 'Enter a description of the finished dish',
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
              //dropdown menu for difficulty selection
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
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButtonFormField(
                      iconEnabledColor: Colors.white,
                      isExpanded: true,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        labelText: 'Select recipe difficulty',
                        labelStyle: whiteText,
                      ),
                      //dropdown menu labels
                      dropdownColor: Colors.red[300],
                      value: DBControl.difficultyValue,
                      items: ["Easy", "Intermediate", "Hard"]
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
                        setState(() => DBControl.difficultyValue = value);
                      },
                    ),
                  ),
                ),
              ),
              divider,
              //textfield for the user to enter the number of servings
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextField(
                  controller: DBControl.servingsController,
                  textAlign: TextAlign.start,
                  keyboardType:
                      TextInputType.number, //only shows a numerical keyboard
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter
                        .digitsOnly //enables digits only for entry
                  ],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: 'How many servings does it make?',
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
              //preptime
              Padding(
                padding:
                    const EdgeInsets.only(top: 13.0, bottom: 13.0, left: 25.0),
                //text for the title
                child: Row(
                  children: [
                    Text(
                      'How long to prepare and cook?',
                      style: blackText,
                    )
                  ],
                ),
              ),
              //create a row to hold the hours and mins textfields
              Row(
                children: [
                  //hours textfield
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: TextField(
                        controller: DBControl.hoursController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType
                            .number, //only shows a numerical keyboard
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly //enables digits only for entry
                        ],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          labelText: 'Hours',
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
                  ),
                  //textfield for minutes
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: TextField(
                        controller: DBControl.minutesController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType
                            .number, //only shows a numerical keyboard
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly //enables digits only for entry
                        ],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          labelText: 'Minutes',
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
                  ),
                ],
              ),
              divider,
              //allergies
              Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: _allergiesCheckList(
                    'Allergies affected',
                    _allergiesList,
                    whiteText,
                  )),
              divider,
              //category (vegan, vegetarian or non-vegetarian)
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
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButtonFormField(
                      iconEnabledColor: Colors.white,
                      isExpanded: true,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        labelText: 'Recipe category:',
                        labelStyle: whiteText,
                      ),
                      //dropdown menu labels
                      dropdownColor: Colors.red[300],
                      value: DBControl.categoryValue,
                      items: ["Vegan", "Vegetarian", "Non-Vegetarian"]
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
                        setState(() => DBControl.categoryValue = value);
                      },
                    ),
                  ),
                ),
              ),
              divider,
              //proteins
              Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: _proteinsCheckList(
                    'Protein:',
                    _proteinList,
                    whiteText,
                  )),
              divider,
              //cancel and next buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: SizedBox(
                      width: 100,
                      height: 50,
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.red[50]),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (DBControl.categoryValue != null) {
                            DBControl.categoryValue = null;
                          }
                          if (DBControl.difficultyValue != null) {
                            DBControl.difficultyValue = null;
                          }
                          DBControl.clearDBVariables();
                          DBControl.popPage(1, context);
                          //Navigator.pop(context);
                          MaterialPageRoute(
                              builder: (BuildContext context) => ProfilePage());
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: SizedBox(
                      width: 100,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        child: Text(
                          'Done',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (DBControl.recipeNameController.text.isEmpty ||
                              DBControl.servingsController.text.isEmpty ||
                              DBControl.descriptionController.text.isEmpty ||
                              DBControl.hoursController.text.isEmpty ||
                              DBControl.minutesController.text.isEmpty ||
                              DBControl.difficultyValue == null ||
                              DBControl.categoryValue == null ||
                              DBControl.allergies == null ||
                              DBControl.proteins == null) {
                            //snackbar shown if any of the fields are empty
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } else {
                            //if not empty, add to the list
                            _setPrepTime(DBControl.hoursController.text,
                                DBControl.minutesController.text);
                            //Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        IngredientsSubmission()));
                          }
                        },
                      ),
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  //helper method for the allergies checkboxes
  Widget _allergiesCheckList(
    String title,
    List checklistOptions,
    var textStyle,
  ) {
    return MultiSelectFormField(
      autovalidate: false,
      fillColor: Colors.red[400],
      chipBackGroundColor: Colors.white,
      chipLabelStyle: TextStyle(color: Colors.red),
      checkBoxActiveColor: Colors.red,
      checkBoxCheckColor: Colors.white,
      dialogShapeBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        title,
        style: textStyle,
      ),
      dataSource: checklistOptions,
      textField: 'display',
      valueField: 'value',
      okButtonLabel: 'OK',
      cancelButtonLabel: 'CANCEL', //clear checklist
      hintWidget: Text(
        'Please choose one or more',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      initialValue: DBControl.allergies,
      onSaved: (value) {
        if (value == null) return;
        setState(() {
          DBControl.allergies = value;
        });
      },
    );
  }

  //helper method for the protein checkboxes
  Widget _proteinsCheckList(
    String title,
    List checklistOptions,
    var textStyle,
  ) {
    return MultiSelectFormField(
      autovalidate: false,
      fillColor: Colors.red[400],
      chipBackGroundColor: Colors.white,
      chipLabelStyle: TextStyle(color: Colors.red),
      checkBoxActiveColor: Colors.red,
      checkBoxCheckColor: Colors.white,
      dialogShapeBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        title,
        style: textStyle,
      ),
      dataSource: checklistOptions,
      textField: 'display',
      valueField: 'value',
      okButtonLabel: 'OK',
      cancelButtonLabel: 'CANCEL', //clear checklist
      hintWidget: Text(
        'Please choose one or more',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      initialValue: DBControl.proteins,
      onSaved: (value) {
        if (value == null) return;
        setState(() {
          DBControl.proteins = value;
        });
      },
    );
  }

  _setPrepTime(String hoursText, String minutesText) {
    int hours = int.parse(hoursText) * 60;
    int minutes = int.parse(minutesText);
    DBControl.prepTime = hours + minutes;
    print(DBControl.prepTime);
  }
}
