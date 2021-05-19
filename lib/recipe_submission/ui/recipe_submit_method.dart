import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youth_food_movement/colours/hex_colours.dart';
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
    color: ceruleanCrayola,
  );
//snackbar if any of the fields are empty and the user tries to add ingredients
//or if the user tries to go to the next page with nothing submitted
  var snackbar = SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: Color(0xFFe62d11),
      content: Text("Please fill out the field before proceeding",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          )));
  //text controller for the textfield
  TextEditingController methodController;

  //colours for the fields
  Color lightPurple = Color(0xFFe62d1);
  Color darkPurple = Color(0xFF7a243e);

  @override
  void initState() {
    super.initState();
    methodController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text('Method',
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
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 13.0, left: 30, bottom: 8.0),
                    child: Text(
                      'Add method instructions:',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  )
                ],
              ),
              //textfield for name of ingredient
              Padding(
                padding: const EdgeInsets.all(13.0),
                //text field to enter the name of the recipe
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[ceruleanCrayola, celadonBlue]),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: celadonBlue)),
                          
                  child: Padding(
                    padding: const EdgeInsets.only(left:8.0, right: 8.0),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: methodController,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        labelText: 'Enter step',
                        labelStyle: TextStyle(
                            color: white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),

                        enabledBorder: InputBorder.none
                      ),
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
                            primary: greenSheen),
                        child: Text(
                          'NEXT',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
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
                              fontWeight: FontWeight.w500,
                              color: white,
                              fontSize: 20,
                            ),
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
                                    backgroundColor: celadonBlue,
                                    radius: 10,
                                  ),
                                  title: Text(
                                      DBControl.methodSteps[index].toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: white)),
                                ),
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
              divider,
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
                            primary: greenSheen,
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
                            DBControl.clearDBVariables();
                            methodController.clear();
                            DBControl.popPage(3, context);
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
    );
  }
}
