import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:youth_food_movement/homepage/HomePage.dart';
import 'package:youth_food_movement/login/user_search/data_controller.dart';
import 'authentication_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class UserDetailPage extends StatefulWidget {
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  var firestoreDb = FirebaseFirestore.instance.collection('Users').snapshots();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: 'gs://youth-food-movement.appspot.com');
  TextEditingController usernameInputController;
  TextEditingController fullNameInputController;
  String regionDropdownValue;
  int imageSelected;
  bool usernameExists = true;
  final f = new DateFormat('dd-MMM-yyyy');
  DateTime birthday = DateTime.now();
  QuerySnapshot snapshotData;
  List _allergies;

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: birthday,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != birthday)
      setState(() {
        birthday = pickedDate;
      });
  }

  @override
  void initState() {
    super.initState();
    //initialise and instantiate the text controllers
    usernameInputController = TextEditingController();
    fullNameInputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    //refactored textstyle used buttons/textfields
    var whiteText = TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
    /*var blackText = TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
    //refactored dividers
    var divider = Divider(
      height: 10,
      thickness: 3,
      indent: 20,
      endIndent: 20,
      color: Colors.black,
    );*/

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              AppBar(
                backgroundColor: Colors.red,
                leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 25,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                title: Text('User Detail Page',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    )),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 13.0, right: 13.0, top: 4.0),
                    child: SizedBox(
                      height: 50,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red[400],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Select Prefered Avatar",
                            style: whiteText,
                          )),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: IconButton(
                            icon: Image.network(
                                "https://cdn.pixabay.com/photo/2021/03/29/11/44/muffins-6133902_1280.jpg"),
                            iconSize: 160,
                            onPressed: () {
                              imageSelected = 1;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: IconButton(
                            icon: Image.network(
                                "https://cdn.pixabay.com/photo/2021/03/29/11/44/muffins-6133902_1280.jpg"),
                            iconSize: 160,
                            onPressed: () {
                              imageSelected = 2;
                            }),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: IconButton(
                            icon: Image.network(
                                "https://cdn.pixabay.com/photo/2021/03/29/11/44/muffins-6133902_1280.jpg"),
                            iconSize: 160,
                            onPressed: () {
                              imageSelected = 3;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: IconButton(
                            icon: Image.network(
                                "https://cdn.pixabay.com/photo/2021/03/29/11/44/muffins-6133902_1280.jpg"),
                            iconSize: 160,
                            onPressed: () {
                              imageSelected = 4;
                            }),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 13, top: 7),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Full Name',
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
                      controller: fullNameInputController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 13, top: 7),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 310,
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Username',
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
                            controller: usernameInputController,
                          ),
                        ),
                        GetBuilder<DataController>(
                            init: DataController(),
                            builder: (val) {
                              return IconButton(
                                  icon: Icon(Icons.check),
                                  onPressed: () {
                                    val
                                        .usernameQueryData(
                                            usernameInputController.text)
                                        .then((value) {
                                      snapshotData = value;
                                      if (snapshotData.docs.isEmpty) {
                                        setState(() {
                                          usernameExists = false;
                                        });
                                        final snackBar = SnackBar(
                                          content:
                                              Text('Username does not exist'),
                                          duration:
                                              Duration(milliseconds: 1000),
                                          backgroundColor: Colors.green,
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } else {
                                        setState(() {
                                          usernameExists = true;
                                        });
                                        final snackBar = SnackBar(
                                          content: Text('Username exists'),
                                          duration:
                                              Duration(milliseconds: 1000),
                                          backgroundColor: Colors.red,
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    });
                                  });
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 13, top: 7),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7.0),
                          child: SizedBox(
                            height: 40,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.red[400],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Enter Birthday",
                                  style: whiteText,
                                )),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red[400],
                          ),
                          child: TextButton(
                              onPressed: () => _selectDate(context),
                              child: Text(
                                f.format(birthday).toString(),
                                style: whiteText,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 13, right: 13, top: 7),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red[400],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DropdownButtonFormField(
                            iconEnabledColor: Colors.white,
                            isExpanded: true,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              labelText: 'Select Your Region',
                              labelStyle: whiteText,
                            ),
                            dropdownColor: Colors.red[300],
                            value: regionDropdownValue,
                            items: [
                              "Northland",
                              "Auckland",
                              "Waikato",
                              "Bay of Plenty",
                              "Gisborne",
                              "Hawke's Bay",
                              "Taranaki",
                              "Manawatu-Whanganui",
                              "Wellington",
                              "Tasman",
                              "Nelson",
                              "Marlborough",
                              "West Coast",
                              "Canterbury",
                              "Otago",
                              "Southland"
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
                              setState(() => regionDropdownValue = value);
                            },
                          ),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: _allergiesCheckList(
                        'Allergies affected',
                        _allergiesList,
                        whiteText,
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      //button to clear the textfields
                      onPressed: () {
                        fullNameInputController.clear();
                        usernameInputController.clear();
                        imageSelected = null;
                        regionDropdownValue = null;
                        birthday = DateTime.now();
                        //Navigator.pop(context);
                        context.read<AuthenticationService>().signOut();
                      },
                      padding: const EdgeInsets.only(right: 120),
                      icon: Icon(Icons.clear),
                      iconSize: 30),
                  IconButton(
                    //button to check if datas are all entered and save data to the database
                    onPressed: () {
                      if (fullNameInputController.text.isNotEmpty) {
                        if (usernameInputController.text.isNotEmpty) {
                          //change to false later
                          if (usernameExists = true) {
                            if (imageSelected != null) {
                              if (regionDropdownValue != null) {
                                if (f.format(birthday) !=
                                    f.format(DateTime.now())) {
                                  FirebaseFirestore.instance
                                      .collection('Users')
                                      .add({
                                    'uid': _firebaseAuth.currentUser.uid,
                                    'Name': fullNameInputController.text,
                                    'Username': usernameInputController.text,
                                    'Image': imageSelected,
                                    'Region': regionDropdownValue,
                                    'Birthday': f.format(birthday),
                                    'Accounted Created Time':
                                        f.format(new DateTime.now()),
                                    'Allergy': _allergies
                                  });
                                  final snackBar = SnackBar(
                                    content:
                                        Text('Account Successfully Created'),
                                    duration: Duration(milliseconds: 1000),
                                    backgroundColor: Colors.green,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                  );
                                } else {
                                  final snackBar = SnackBar(
                                    content:
                                        Text('Birthday has not been selected'),
                                    duration: Duration(milliseconds: 1000),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              } else {
                                final snackBar = SnackBar(
                                  content: Text('Region has not been selected'),
                                  duration: Duration(milliseconds: 1000),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            } else {
                              final snackBar = SnackBar(
                                content: Text('Image has not been selected'),
                                duration: Duration(milliseconds: 1000),
                                backgroundColor: Colors.red,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } else {
                            final snackBar = SnackBar(
                              content: Text('Username already exists'),
                              duration: Duration(milliseconds: 1000),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        } else {
                          final snackBar = SnackBar(
                            content: Text('Username is not entered'),
                            duration: Duration(milliseconds: 1000),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } else {
                        final snackBar = SnackBar(
                          content: Text('Name is not entered'),
                          duration: Duration(milliseconds: 1000),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    icon: Icon(Icons.save),
                    iconSize: 30,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //helper method for the checkboxes
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
        'Select allergies',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      initialValue: _allergies,
      onSaved: (value) {
        if (value == null) return;
        setState(() {
          _allergies = value;
        });
      },
    );
  }
}
