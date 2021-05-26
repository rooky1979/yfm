import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:youth_food_movement/colours/hex_colours.dart';
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
//list for the recipe tags
  List<dynamic> _tagsList = [
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
    {
      "display": "Pasta",
      "value": "Pasta",
    },
    {
      "display": "Salad",
      "value": "Salad",
    },
    {
      "display": "Rice",
      "value": "Rice",
    },
    {
      "display": "Dessert",
      "value": "Dessert",
    },
  ];
  //snackbar if any of the fields are empty and the user tries to add ingredients
//or if the user tries to go to the next page with nothing submitted
  var snackbar = SnackBar(
    duration: Duration(seconds: 2),
    backgroundColor: orangeRed,
    content: Text(
      "Please fill out all fields before proceeding",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );

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
    var darkPurpleText = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: textLabelColor,
    );
    //refactored dividers for continual use

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
        backgroundColor: background,
        resizeToAvoidBottomInset: false,
        //appbar with title and back arrow
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[gradientColourA, gradientColourB],
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              size: 25,
              color: white,
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
            },
          ),
          title: Text(
            'Submit your recipe!',
            style: TextStyle(
              color: white,
              fontSize: 23,
            ),
          ),
        ),
        //container to hold the column
        body: SingleChildScrollView(
          //makes the view scrollable
          child: FittedBox(
            child: Container(
              width: MediaQuery.of(context).size.width,
              //column to hold the all the user options
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    //text field to enter the name of the recipe
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: DBControl.recipeNameController,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: textLabelColor,
                        fontSize: 17,
                      ),
                      decoration: InputDecoration(
                        labelText: 'What is the name of your recipe?',
                        labelStyle: TextStyle(
                            color: textLabelColor, fontWeight: FontWeight.w500),
                        fillColor: textfieldBackground,
                        filled: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: textLabelColor, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: textLabelColor, width: 3),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    //text field to enter the name of the recipe
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: DBControl.descriptionController,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: textLabelColor,
                        fontSize: 17,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Enter a description of the finished dish.',
                        labelStyle: TextStyle(
                            color: textLabelColor, fontWeight: FontWeight.w500),
                        fillColor: textfieldBackground,
                        filled: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: textLabelColor, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: textLabelColor, width: 3),
                        ),
                      ),
                    ),
                  ),
                  //dropdown menu for difficulty selection
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    //create a container and decorate
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            textfieldBackground,
                            textfieldBackground
                          ],
                        ),
                        //border: Border.all(color: textLabelColor),
                        //borderRadius: BorderRadius.circular(15),
                      ),
                      //width: MediaQuery.of(context).size.width,
                      //create a drop down menu and remove the underline
                      child: DropdownButtonFormField(
                        iconEnabledColor: textLabelColor,
                        isExpanded: true,
                        decoration: InputDecoration(
                          //enabledBorder: InputBorder.none,
                          labelText: 'Select recipe difficulty',
                          labelStyle: TextStyle(
                              color: textLabelColor,
                              fontWeight: FontWeight.w500),
                          fillColor: textfieldBackground,
                          filled: true,
                          //enabledBorder: InputBorder.none,
                          // focusedBorder: UnderlineInputBorder(
                          //   borderSide:
                          //       BorderSide(color: textLabelColor, width: 3),
                          // ),
                        ),
                        //dropdown menu labels
                        dropdownColor: textfieldBackground,
                        value: DBControl.difficultyValue,
                        items: ["Easy", "Intermediate", "Hard"]
                            .map(
                              (label) => DropdownMenuItem(
                                child: Center(
                                  child: Text(
                                    label,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: textLabelColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                value: label,
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() => DBControl.difficultyValue = value);
                        },
                      ),
                    ),
                  ),
                  //textfield for the user to enter the number of servings
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: TextField(
                      controller: DBControl.servingsController,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType
                          .number, //only shows a numerical keyboard
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter
                            .digitsOnly //enables digits only for entry
                      ],
                      style: TextStyle(
                        color: textLabelColor,
                        fontSize: 17,
                      ),
                      decoration: InputDecoration(
                        labelText: 'How many servings does it make?',
                        labelStyle: TextStyle(
                            color: textLabelColor, fontWeight: FontWeight.w500),
                        fillColor: textfieldBackground,
                        filled: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: textLabelColor, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: textLabelColor, width: 3),
                        ),
                      ),
                    ),
                  ),
                  //preptime
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 13.0, bottom: 13.0, left: 25.0),
                    //text for the title
                    child: Row(
                      children: [
                        Text(
                          'How long to prepare and cook?',
                          style: TextStyle(
                              color: textLabelColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 23),
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
                              color: textLabelColor,
                              fontSize: 17,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Hours',
                              labelStyle: TextStyle(
                                  color: textLabelColor,
                                  fontWeight: FontWeight.w500),
                              fillColor: textfieldBackground,
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: textLabelColor, width: 2),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: textLabelColor, width: 3),
                              ),
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
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter
                                  .digitsOnly //enables digits only for entry
                            ],
                            style: TextStyle(
                              color: textLabelColor,
                              fontSize: 17,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Minutes',
                              labelStyle: TextStyle(
                                  color: textLabelColor,
                                  fontWeight: FontWeight.w500),
                              fillColor: textfieldBackground,
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: textLabelColor, width: 2),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: textLabelColor, width: 3),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //allergies
                  Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: _allergiesCheckList(
                        'Allergies affected',
                        _allergiesList,
                        textLabelColor,
                      )),
                  //category (vegan, vegetarian or non-vegetarian)
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    //create a container and decorate
                    child: Container(
                      decoration: BoxDecoration(
                          // gradient: LinearGradient(
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.bottomCenter,
                          //   colors: <Color>[gradientColourA, gradientColourB],
                          // ),
                          // border: Border.all(color: gradientColourB),
                          // borderRadius: BorderRadius.circular(15),+9
                          color: textfieldBackground),
                      //width: MediaQuery.of(context).size.width,
                      //create a drop down menu and remove the underline
                      child: DropdownButtonFormField(
                        iconEnabledColor: textLabelColor,
                        isExpanded: true,
                        decoration: InputDecoration(
                          //enabledBorder: InputBorder.none,
                          labelText: 'Recipe category:',
                          labelStyle: TextStyle(
                              color: textLabelColor,
                              fontWeight: FontWeight.w500),
                          filled: true,
                          //enabledBorder: InputBorder.none,
                        ),
                        //dropdown menu labels
                        dropdownColor: textfieldBackground,
                        value: DBControl.categoryValue,
                        items: ["Vegan", "Vegetarian", "Non-Vegetarian"]
                            .map(
                              (label) => DropdownMenuItem(
                                child: Center(
                                  child: Text(
                                    label,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: textLabelColor,
                                    ),
                                  ),
                                ),
                                value: label,
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() => DBControl.categoryValue = value);
                        },
                      ),
                    ),
                  ),
                  //proteins
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: _recipeTagsCheckList(
                      'Recipe Tags:',
                      _tagsList,
                      darkPurpleText,
                    ),
                  ),
                  //cancel and next buttons
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
                                  primary: buttonPrimary),
                              child: Text(
                                'DONE',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                if (DBControl
                                        .recipeNameController.text.isEmpty ||
                                    DBControl.servingsController.text.isEmpty ||
                                    DBControl
                                        .descriptionController.text.isEmpty ||
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
                                          IngredientsSubmission(),
                                    ),
                                  );
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
                                primary: white, // background
                              ),
                              child: Text(
                                'CANCEL',
                                style: TextStyle(
                                    color: buttonPrimary,
                                    fontWeight: FontWeight.bold),
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
                                  builder: (BuildContext context) =>
                                      ProfilePage(),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
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
    return Container(
      decoration: BoxDecoration(
        //border: Border.all(color: celadonBlue),
        borderRadius: BorderRadius.circular(11.0),
      ),
      child: MultiSelectFormField(
        autovalidate: false,
        fillColor: textfieldBackground,
        chipBackGroundColor: textLabelColor,
        chipLabelStyle: TextStyle(color: white),
        checkBoxActiveColor: textLabelColor,
        checkBoxCheckColor: white,
        border: InputBorder.none,
        dialogShapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
          title,
          style: TextStyle(
              color: textLabelColor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        dataSource: checklistOptions,
        textField: 'display',
        valueField: 'value',
        okButtonLabel: 'OK',
        cancelButtonLabel: 'CANCEL', //clear checklist
        hintWidget: Text(
          'Please choose one or more',
          style: TextStyle(fontWeight: FontWeight.bold, color: textLabelColor),
        ),
        initialValue: DBControl.allergies,
        onSaved: (value) {
          if (value == null) return;
          setState(
            () {
              DBControl.allergies = value;
            },
          );
        },
      ),
    );
  }

  //helper method for the protein checkboxes
  Widget _recipeTagsCheckList(
    String title,
    List checklistOptions,
    var textStyle,
  ) {
    return Container(
      decoration: BoxDecoration(
        //border: Border.all(color: gradientColourB),
        borderRadius: BorderRadius.circular(11.0),
      ),
      child: MultiSelectFormField(
        autovalidate: false,
        fillColor: textfieldBackground,
        chipBackGroundColor: textLabelColor,
        chipLabelStyle: TextStyle(color: textfieldBackground),
        checkBoxActiveColor: textLabelColor,
        checkBoxCheckColor: white,
        border: InputBorder.none,
        dialogShapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: textLabelColor),
        ),
        dataSource: checklistOptions,
        textField: 'display',
        valueField: 'value',
        okButtonLabel: 'OK',
        cancelButtonLabel: 'CANCEL', //clear checklist
        hintWidget: Text(
          'Please choose one or more',
          style: TextStyle(fontWeight: FontWeight.bold, color: textLabelColor),
        ),
        initialValue: DBControl.proteins,
        onSaved: (value) {
          if (value == null) return;
          setState(
            () {
              DBControl.proteins = value;
            },
          );
        },
      ),
    );
  }

  _setPrepTime(String hoursText, String minutesText) {
    int hours = int.parse(hoursText) * 60;
    int minutes = int.parse(minutesText);
    DBControl.prepTime = hours + minutes;
    print(DBControl.prepTime);
  }
}
