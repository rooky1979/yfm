import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:youth_food_movement/login/login_page.dart';
import 'package:youth_food_movement/login/user_detail_page.dart';
import 'package:youth_food_movement/login/curved_widget.dart';
import 'package:youth_food_movement/login/user_search/data_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'authentication_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //controllers for text fields
  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();
  //used for searching if email already exist in login
  QuerySnapshot snapshotData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        color: Color(0xFFf0f1eb),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              CurvedWidget(
                child: Container(
                  padding: const EdgeInsets.only(top: 100, left: 50),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.red[400],
                          Colors.white.withOpacity(0.95)
                        ]),
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: AssetImage('lib/logo/just-cook-logo.png'),
                  )),
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(top: 250),
                  child: Column(
                    children: [
                      Container(
                        width: 250,
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 15),
                        child: TextField(
                          controller: emailInputController,
                          cursorColor: Color(0xFF7a243e),
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.mail_outline, color: Colors.black),
                            labelText: 'Email',
                            fillColor: Color(0xFFe62d1),
                            filled: true,
                            labelStyle: TextStyle(
                              color: Color(0xFF7a243e),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF7a243e), width: 2),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF7a243e), width: 3),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 15),
                        child: TextField(
                          controller: passwordInputController,
                          obscureText: true,
                          cursorColor: Color(0xFF7a243e),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline_rounded,
                                color: Colors.black),
                            focusColor: Color(0xFFe62d11),
                            labelText: 'Password',
                            fillColor: Color(0xFFe62d1),
                            filled: true,
                            labelStyle: TextStyle(
                              color: Color(0xFF7a243e),
                            ),
                            hintStyle: TextStyle(
                              color: Color(0xFE7a243e),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF7a243e), width: 2),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF7a243e), width: 3),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 180,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: GetBuilder<DataController>(
                              init: DataController(),
                              builder: (val) {
                                return ElevatedButton(
                                  onPressed: () {
                                    //check if email has been entered
                                    if (emailInputController.text.isNotEmpty) {
                                      //check if password has been entered
                                      if (passwordInputController
                                          .text.isNotEmpty) {
                                        val
                                            .emailQueryData(
                                                emailInputController.text)
                                            .then((value) {
                                          snapshotData = value;
                                          //check if email already exists
                                          if (snapshotData.docs.isEmpty) {
                                            if (validateEmail(
                                                emailInputController.text))
                                            //check if password is longer than 6 letters
                                            if (passwordInputController
                                                    .text.length >=
                                                6) {
                                              //signup account with entered email and password if both are entered
                                              context
                                                  .read<AuthenticationService>()
                                                  .signUp(
                                                    email: emailInputController
                                                        .text
                                                        .trim(),
                                                    password:
                                                        passwordInputController
                                                            .text
                                                            .trim(),
                                                  );
                                              //move to next page
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserDetailPage()),
                                              );
                                            } else {
                                              final snackBar = SnackBar(
                                                content: Text(
                                                    'Password is not 6 letters or longer'),
                                                duration: Duration(
                                                    milliseconds: 1000),
                                                backgroundColor:
                                                    Color(0xFFe62d11),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                            else {
                                              final snackBar = SnackBar(
                                                content: Text(
                                                    'Please enter a valid email!'),
                                                duration: Duration(
                                                    milliseconds: 1000),
                                                backgroundColor:
                                                    Color(0xFFe62d11),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          } else {
                                            final snackBar = SnackBar(
                                              content:
                                                  Text('Email already exists'),
                                              duration:
                                                  Duration(milliseconds: 1000),
                                              backgroundColor:
                                                  Color(0xFFe62d11),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                        });
                                      } else {
                                        final snackBar = SnackBar(
                                          content: Text('Password not entered'),
                                          duration:
                                              Duration(milliseconds: 1000),
                                          backgroundColor: Color(0xFFe62d11),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    } else {
                                      final snackBar = SnackBar(
                                        content: Text('email not entered'),
                                        duration: Duration(milliseconds: 1000),
                                        backgroundColor: Color(0xFFe62d11),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  child: Text("NEXT"),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 4,
                                    primary: Color(0xFF4ca5b5), // background
                                    onPrimary: Colors.white, // foreground
                                  ),
                                );
                              }),
                        ),
                      ),
                      //button to cancel registration and go back to login page
                      Container(
                        width: 180,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: OutlinedButton(
                            onPressed: () {
                              final snackBar = SnackBar(
                                content: Text('Register Cancelled'),
                                duration: Duration(milliseconds: 1000),
                                backgroundColor: Color(0xFFe62d11),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogIn()),
                              );
                            },
                            child: Text("BACK"),
                            style: OutlinedButton.styleFrom(
                              primary: Color(0xFF4ca5b5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return false;
    else
      return true;
  }
}
