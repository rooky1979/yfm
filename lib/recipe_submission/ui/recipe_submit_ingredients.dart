import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  //text controller for the textfield
  TextEditingController ingredientController;
  TextEditingController amountController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ingredientController = TextEditingController();
    amountController = TextEditingController();
  }

  //string to hold the unit
  String unit = '';
  //list to hold ingredient strings
  List ingredients = [];
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
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 30, bottom: 8.0),
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
                        labelText: 'Enter amount',
                        labelStyle: whiteText,
                        fillColor: Colors.red[400],
                        filled: true,
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 3.0),
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
                        style: ElevatedButton.styleFrom(primary: Colors.white),
                        child: Text(
                          'Previous',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          ingredients
                              .removeLast(); //remove last ingredient from the list
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
                        style:
                            ElevatedButton.styleFrom(primary: Colors.red[100]),
                        child: Text(
                          'Next',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(() {});
                          ingredients.add(amountController.text +
                              ' ' +
                              unit +
                              ' ' +
                              ingredientController.text);
                          amountController.clear();
                          ingredientController.clear();
                        },
                      ),
                    ),
                  )
                ],
              ),
              divider,
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
                          //physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: ingredients.length,
                          itemBuilder: (context, int index) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 10,
                                  ),
                                  title: Text(ingredients[index].toString(),
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
            ],
          )),
    );
  }
}
/*               divider,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.grey),
                        child: Text('Cancel',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        onPressed: () {
                          Navigator.pop(context);
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
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        child: Text('Done',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                        onPressed: () {
                          // Respond to button press
                        },
                      ),
                    ),
                  )
                ],
              ), */
