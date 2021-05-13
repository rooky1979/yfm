import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youth_food_movement/homepage/profile_page.dart';
import 'package:youth_food_movement/recipe_submission/network/db_control.dart';
import 'package:youth_food_movement/recipe_submission/ui/recipe_submit_image.dart';

class MethodSubmission extends StatefulWidget {
  @override
  _MethodSubmissionState createState() => _MethodSubmissionState();
}

class _MethodSubmissionState extends State<MethodSubmission> {
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
    color: Color(0xFF7a243e),
  );
//snackbar if any of the fields are empty and the user tries to add ingredients
//or if the user tries to go to the next page with nothing submitted
  var snackbar = SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: Colors.blue[600],
      content: Text("Please fill out the field before proceeding",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          )));
  //text controller for the textfield
  TextEditingController methodController;

  @override
  void initState() {
    super.initState();
    methodController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appbar with title and back arrow
      appBar: AppBar(
        backgroundColor: new Color(0xFFe62d11),
        leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              size: 25,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Method',
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
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 13.0, left: 30, bottom: 8.0),
                    child: Text(
                      'Add method instructions:',
                      style: TextStyle(color: Color(0xFF7a243e), fontSize: 20),
                    ),
                  )
                ],
              ),
              //textfield for name of ingredient
              Padding(
                padding: const EdgeInsets.all(13.0),
                //text field to enter the name of the recipe
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: methodController,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color(0xFF7a243e),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: 'Enter step',
                    labelStyle: whiteText,
                    fillColor: new Color(0xFFe62d11),
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF7a243e), width: 2),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF7a243e), width: 3),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: Color(0xFF4ca5b5),
                        ),
                        child: Text(
                          'PREVIOUS',
                          style: TextStyle(
                              color: new Color(0xFFe62d11),
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(() {});
                          if (DBControl.methodSteps.isNotEmpty) {
                            DBControl.methodSteps.removeLast();
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
                            primary: Color(0xFF4ca5b5)),
                        child: Text(
                          'NEXT',
                          style: TextStyle(
                              color: new Color(0xFFe62d11),
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (methodController.text.isEmpty) {
                            //snackbar shown if any of the fields are empty
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } else {
                            //if not empty, add to the list
                            setState(() {});
                            DBControl.methodSteps.add(methodController.text);
                            methodController.clear();
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
              divider,
              //List to show added items so far
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
                                color: Color(0xFF7a243e), fontSize: 20),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: DBControl.methodSteps.length,
                          itemBuilder: (context, int index) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: new Color(0xFFe62d11),
                                    radius: 10,
                                  ),
                                  title: Text(
                                      DBControl.methodSteps[index].toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF7a243e))),
                                ),
                                Divider(
                                  height: 10,
                                  thickness: 2,
                                  indent: 40,
                                  endIndent: 20,
                                  color: Color(0xFF7a243e),
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
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: Color(0xFF4ca5b5),
                        ),
                        child: Text(
                          'CANCEL',
                          style: TextStyle(
                              color: new Color(0xFFe62d11),
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          DBControl.clearDBVariables();
                          methodController.clear();
                          DBControl.popPage(3, context);
                          MaterialPageRoute(
                              builder: (BuildContext context) => ProfilePage());
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
                          primary: new Color(0xFFe62d11),
                        ),
                        child: Text(
                          'DONE',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (DBControl.methodSteps.isEmpty) {
                            //snackbar shown if any of the fields are empty
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } else {
                            //Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ImageSubmission()));
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
