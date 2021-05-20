import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:youth_food_movement/login/login_page.dart';
import 'package:youth_food_movement/login/user_search/data_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:youth_food_movement/colours/hex_colours.dart';

class UserDetailPage extends StatefulWidget {
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  //reference to firestore database
  var firestoreDb = FirebaseFirestore.instance.collection('Users').snapshots();

  //reference to firebase auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //reference to firebase storage
  final FirebaseStorage avatarStorage = FirebaseStorage.instanceFor(
      bucket: 'gs://youth-food-movement.appspot.com');

  //Controllers for textfields
  TextEditingController usernameInputController;
  TextEditingController fullNameInputController;

  //date formatted to day/month/year
  final formattedDate = new DateFormat('dd-MMM-yyyy');
  DateTime today = DateTime.now();

  //used for searching if username already exist check button
  QuerySnapshot snapshotData;

  //other variables used for this class
  String _regionDropdownValue;
  String _imageSelected;
  bool usernameExists = true;
  String _username;
  List _allergies;

  //list of allergy list in array for multi select form
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

  //Function used to pick a date(birthday)
  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(2000),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != today)
      setState(() {
        today = pickedDate;
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
    final filter = ProfanityFilter();
    var whiteText = TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
    var darkPurpleText = TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF7a243e));

    return Scaffold(
      backgroundColor: onyx,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Account Setup',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[cream, radicalRed])),
        ),
        /*  backgroundColor: radicalRed,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 20,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Account Set-Up',
            style: TextStyle(
              color: Colors.white,

              fontSize: 20,
            )), */
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  //Label for select avatars
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 13.0, right: 13.0, top: 12.0, bottom: 5.0),
                    child: SizedBox(
                      height: 50,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[turquoiseGreen, greenSheen]),
                            borderRadius: BorderRadius.circular(15),
                            color: celadonBlue,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Select Prefered Avatar",
                            style: whiteText,
                          )),
                    ),
                  ),
                  //1st row of button with avatar image from database
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.25,
                              margin: EdgeInsets.all(8.0),
                              child: Card(
                                child: FutureBuilder(
                                    future: _getImage1URL(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        //this creates the pictures to be clickable
                                        //and will take the user to the recipe page
                                        return GestureDetector(
                                          child: Image.network(
                                            snapshot.data,
                                            fit: BoxFit.cover,
                                          ),
                                          onTap: () {
                                            _imageSelected = "avatar1.jpg";
                                            final snackBar = SnackBar(
                                              content:
                                                  Text('Avatar 1 selected'),
                                              duration:
                                                  Duration(milliseconds: 1000),
                                              backgroundColor: Colors.green,
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          },
                                        );
                                      } else {
                                        return Container(
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                      }
                                    }),
                              ),
                            )),
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.25,
                              margin: EdgeInsets.all(8.0),
                              child: Card(
                                child: FutureBuilder(
                                    future: _getImage2URL(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        //this creates the pictures to be clickable
                                        //and will take the user to the recipe page
                                        return GestureDetector(
                                          child: Image.network(
                                            snapshot.data,
                                            fit: BoxFit.cover,
                                          ),
                                          onTap: () {
                                            _imageSelected = "avatar2.jpg";
                                            final snackBar = SnackBar(
                                              content:
                                                  Text('Avatar 2 selected'),
                                              duration:
                                                  Duration(milliseconds: 1000),
                                              backgroundColor: Colors.green,
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          },
                                        );
                                      } else {
                                        return Container(
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                      }
                                    }),
                              ),
                            )),
                      ],
                    ),
                  ),
                  //2nd row of button with avatar image from database
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.25,
                            margin: EdgeInsets.all(8.0),
                            child: Card(
                              child: FutureBuilder(
                                  future: _getImage3URL(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      //this creates the pictures to be clickable
                                      //and will take the user to the recipe page
                                      return GestureDetector(
                                        child: Image.network(
                                          snapshot.data,
                                          fit: BoxFit.cover,
                                        ),
                                        onTap: () {
                                          _imageSelected = "avatar3.jpg";
                                          final snackBar = SnackBar(
                                            content: Text('Avatar 3 selected'),
                                            duration:
                                                Duration(milliseconds: 1000),
                                            backgroundColor: Colors.green,
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        },
                                      );
                                    } else {
                                      return Container(
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    }
                                  }),
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.25,
                            margin: EdgeInsets.all(8.0),
                            child: Card(
                              child: FutureBuilder(
                                  future: _getImage4URL(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      //this creates the pictures to be clickable
                                      //and will take the user to the recipe page
                                      return GestureDetector(
                                        child: Image.network(
                                          snapshot.data,
                                          fit: BoxFit.cover,
                                        ),
                                        onTap: () {
                                          _imageSelected = "avatar4.jpg";
                                          final snackBar = SnackBar(
                                            content: Text('Avatar 4 selected'),
                                            duration:
                                                Duration(milliseconds: 1000),
                                            backgroundColor: Colors.green,
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        },
                                      );
                                    } else {
                                      return Container(
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    }
                                  }),
                            ),
                          )),
                    ],
                  ),
                  //Textfield for name

                  Container(
                    // width: 250,
                    padding: const EdgeInsets.only(
                        left: 13, right: 13, top: 7, bottom: 10),
                    child: TextField(
                      controller: fullNameInputController,
                      cursorColor: greenSheen,
                      decoration: InputDecoration(
                        //prefixIcon:
                        // Icon(Icons.mail_outline, color: Colors.black),
                        labelText: 'Full Name',
                        fillColor: turquoiseGreen, //light purple
                        filled: true,
                        labelStyle: TextStyle(
                          color: greenSheen, //dark purple
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greenSheen, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greenSheen, width: 3),
                        ),
                      ),
                    ),
                  ),
                  //textfield for username and check button to check if username already exists
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 13, right: 13, top: 7, bottom: 10),
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TextField(
                              controller: usernameInputController,
                              cursorColor: greenSheen,
                              decoration: InputDecoration(
                                //prefixIcon:
                                // Icon(Icons.mail_outline, color: Colors.black),
                                labelText: 'Username',
                                fillColor: turquoiseGreen,
                                filled: true,
                                labelStyle: TextStyle(
                                  color: greenSheen,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: greenSheen, width: 2),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: greenSheen, width: 3),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: 40,
                            child: GetBuilder<DataController>(
                                init: DataController(),
                                builder: (val) {
                                  return IconButton(
                                      icon: Icon(Icons.check_circle,
                                          size: 40, color: ceruleanCrayola),
                                      onPressed: () {
                                        if (!filter.hasProfanity(
                                            usernameInputController
                                                .text)) if (usernameInputController
                                            .text.isNotEmpty) {
                                          val
                                              .usernameQueryData(
                                                  usernameInputController.text)
                                              .then((value) {
                                            snapshotData = value;
                                            if (snapshotData.docs.isEmpty) {
                                              setState(() {
                                                usernameExists = false;
                                                _username =
                                                    usernameInputController
                                                        .text;
                                                debugPrint(
                                                    usernameExists.toString());
                                              });
                                              final snackBar = SnackBar(
                                                content: Text(
                                                    'Username does not exist'),
                                                duration: Duration(
                                                    milliseconds: 1000),
                                                backgroundColor: Colors.green,
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            } else {
                                              setState(() {
                                                usernameExists = true;
                                                debugPrint(
                                                    usernameExists.toString());
                                              });
                                              final snackBar = SnackBar(
                                                  content:
                                                      Text('Username exists'),
                                                  duration: Duration(
                                                      milliseconds: 1000),
                                                  backgroundColor:
                                                      Color(0xFFe62d11));

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          });
                                        } else {
                                          final snackBar = SnackBar(
                                            content:
                                                Text('Username not entered'),
                                            duration:
                                                Duration(milliseconds: 1000),
                                            backgroundColor: Color(0xFFe62d11),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                        else {
                                          final snackBar = SnackBar(
                                            content: Text(
                                                'Please use appropriate language'),
                                            duration:
                                                Duration(milliseconds: 1000),
                                            backgroundColor: Color(0xFFe62d11),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      });
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //label for enter birthday
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 13, right: 13, top: 7, bottom: 10),
                    child: ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7.0),
                          child: SizedBox(
                            height: 40,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: <Color>[
                                        turquoiseGreen,
                                        greenSheen
                                      ]),
                                  border: Border.all(color: Color(0xFFe62d1)),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xFF7a243e),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Enter Birthday",
                                  style: whiteText,
                                )),
                          ),
                        ),
                        //button to bring out datepicker for birthday
                        Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                //borderRadius: BorderRadius.circular(15),

                                ),
                            child: OutlinedButton.icon(
                              icon: Icon(Icons.calendar_today,
                                  color: Colors.black),
                              onPressed: () => _selectDate(context),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          side: BorderSide(width: 2)))),
                              label: Text(
                                formattedDate.format(today).toString(),
                                style: TextStyle(
                                  color: turquoiseGreen,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  //dropdown button list to pick which region user lives in
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 13, right: 13, top: 7),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: greenSheen), //dark purple
                          borderRadius: BorderRadius.circular(15),
                          color: turquoiseGreen, //light purple
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DropdownButtonFormField(
                            iconEnabledColor: greenSheen, //dark purple
                            isExpanded: true,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              labelText: 'Select Your Region',
                              labelStyle: TextStyle(
                                  color: greenSheen,
                                  fontWeight: FontWeight.w500),
                            ),
                            dropdownColor: turquoiseGreen,
                            value: _regionDropdownValue,
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
                                          style: TextStyle(
                                              color: greenSheen,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      value: label,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() => _regionDropdownValue = value);
                            },
                          ),
                        ),
                      )),

                  //multiselect form for allergy check list
                  Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: _allergiesCheckList(
                        'Allergies affected',
                        _allergiesList,
                        TextStyle(color: greenSheen),
                      )),
                ],
              ),
            ),
            //cancel button and save button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    //button to clear the textfields
                    onPressed: () {
                      fullNameInputController.clear();
                      usernameInputController.clear();
                      _imageSelected = null;
                      _regionDropdownValue = null;
                      today = DateTime.now();
                      _firebaseAuth.currentUser.delete();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    padding: const EdgeInsets.only(right: 120),
                    icon: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                    iconSize: 30),
                IconButton(
                  //button to check if datas are all entered and save data to the database
                  onPressed: () {
                    if (fullNameInputController.text.isNotEmpty) {
                      if (usernameInputController.text.isNotEmpty) {
                        if (usernameExists == false) {
                          if (_imageSelected != null) {
                            if (_regionDropdownValue != null) {
                              if (formattedDate.format(today) !=
                                  formattedDate.format(DateTime.now())) {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .add({
                                  'uid': _firebaseAuth.currentUser.uid,
                                  'email': _firebaseAuth.currentUser.email,
                                  'name': fullNameInputController.text,
                                  'username': _username,
                                  'image': _imageSelected,
                                  'region': _regionDropdownValue,
                                  'birthday': formattedDate.format(today),
                                  'accountedCreatedTime':
                                      formattedDate.format(new DateTime.now()),
                                  'allergy': _allergies,
                                  'favourites': [],
                                  'isModerator': false
                                });
                                final snackBar = SnackBar(
                                  content: Text('Account Successfully Created'),
                                  duration: Duration(milliseconds: 1000),
                                  backgroundColor: Colors.green,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              } else {
                                final snackBar = SnackBar(
                                  content:
                                      Text('Birthday has not been selected'),
                                  duration: Duration(milliseconds: 1000),
                                  backgroundColor: Color(0xFFe62d11),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            } else {
                              final snackBar = SnackBar(
                                content: Text('Region has not been selected'),
                                duration: Duration(milliseconds: 1000),
                                backgroundColor: Color(0xFFe62d11),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } else {
                            final snackBar = SnackBar(
                              content: Text('Image has not been selected'),
                              duration: Duration(milliseconds: 1000),
                              backgroundColor: Color(0xFFe62d11),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        } else {
                          final snackBar = SnackBar(
                            content:
                                Text('Username already exists or not checked'),
                            duration: Duration(milliseconds: 1000),
                            backgroundColor: Color(0xFFe62d11),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } else {
                        final snackBar = SnackBar(
                          content: Text('Username is not entered'),
                          duration: Duration(milliseconds: 1000),
                          backgroundColor: Color(0xFFe62d11),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } else {
                      final snackBar = SnackBar(
                        content: Text('Name is not entered'),
                        duration: Duration(milliseconds: 1000),
                        backgroundColor: Color(0xFFe62d11),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  icon: Icon(Icons.save, color: Colors.white),
                  iconSize: 30,
                )
              ],
            ),
          ],
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
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: greenSheen),
          borderRadius: BorderRadius.circular(11.0)),
      child: MultiSelectFormField(
        autovalidate: false,
        fillColor: turquoiseGreen, //light-purple
        chipBackGroundColor: greenSheen, //dark purple
        chipLabelStyle: TextStyle(color: Colors.white),
        checkBoxActiveColor: greenSheen,
        checkBoxCheckColor: Colors.white,
        border: InputBorder.none,
        dialogShapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: greenSheen)),
        title: Text(
          title,
          style: textStyle, //dark purple
        ),
        dataSource: checklistOptions,
        textField: 'display',
        valueField: 'value',
        okButtonLabel: 'OK',
        cancelButtonLabel: 'CANCEL',
        //clear checklist
        hintWidget: Text(
          'Select allergies',
          style: TextStyle(
              fontWeight: FontWeight.w300, color: greenSheen), //dark purple
        ),
        initialValue: _allergies,
        onSaved: (value) {
          if (value == null) return;
          setState(() {
            _allergies = value;
          });
        },
      ),
    );
  }

  //method for getting avatar images
  Future _getImage1URL() async {
    String downloadURL =
        await avatarStorage.ref('avatar_images/avatar1.jpg').getDownloadURL();
    return downloadURL;
  }

  Future _getImage2URL() async {
    String downloadURL =
        await avatarStorage.ref('avatar_images/avatar2.jpg').getDownloadURL();
    return downloadURL;
  }

  Future _getImage3URL() async {
    String downloadURL =
        await avatarStorage.ref('avatar_images/avatar3.jpg').getDownloadURL();
    return downloadURL;
  }

  Future _getImage4URL() async {
    String downloadURL =
        await avatarStorage.ref('avatar_images/avatar4.jpg').getDownloadURL();
    return downloadURL;
  }
}
