import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:youth_food_movement/recipe_submission/ui/recipe_submit_ingredients.dart';

class InformationSubmission extends StatefulWidget {
  @override
  _InformationSubmissionState createState() => _InformationSubmissionState();
}

//form for the recipe name, servings, preptime, allergies, category and proteins
class _InformationSubmissionState extends State<InformationSubmission> {
  //value used for dropdown selection in dropdown menus
  var _categoryValue;
  var _difficultyValue;
  //value used for the checkbox
  var _myActivities;
  //allergies affects list for the checkbox
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

  @override
  Widget build(BuildContext context) {
    //refactored textstyle used buttons/textfields
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
          /*  */
          child: Container(
            width: MediaQuery.of(context).size.width,
            //column to hold the all the user options
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(13.0),
                //text field to enter the name of the recipe
                child: TextField(
                  //need to send to DB refer to comment section
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
                      value: _difficultyValue,
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
                        setState(() => _difficultyValue = value);
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
                  child: _checkList(
                      'Allergies affected', _allergiesList, whiteText)),
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
                      value: _categoryValue,
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
                        setState(() => _categoryValue = value);
                      },
                    ),
                  ),
                ),
              ),
              divider,
              //proteins
              Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: _checkList('Protein:', _proteinList, whiteText)),
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
                        style: ElevatedButton.styleFrom(primary: Colors.red[50]),
                        child: Text('Cancel',
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                        onPressed: () {
                          Navigator.pop(context);
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
                        child: Text('Next',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    IngredientsSubmission()));
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

//helper method for the checkboxes
  Widget _checkList(String title, List checklistOptions, var textStyle) {
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
      initialValue: _myActivities,
      onSaved: (value) {
        if (value == null) return;
        setState(() {
          _myActivities = value;
        });
      },
    );
  }
}
