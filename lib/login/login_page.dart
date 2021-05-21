import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:youth_food_movement/homepage/home_page.dart';
import 'package:youth_food_movement/login/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youth_food_movement/login/user_search/data_controller.dart';
import 'package:youth_food_movement/login/curved_widget.dart';
import 'package:youth_food_movement/login/register_page.dart';
import 'user_search/data_controller.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Youth Food Movement',
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    //if email and password exist in firebase then move to homepage
    if (firebaseUser != null) {
      return HomePage();
    }
    //if email and password doesnt exist in firebase then move back to login
    return LogIn();
  }
}

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  //Controllers for textfields
  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();

  //used for searching if email already exist in login
  QuerySnapshot snapshotData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: new Color(0xFFf0f1eb),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        //removes back button on appbar
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        color: Color(0xFFf0f1eb),
        height: double.infinity,
        //allows page to be scrollable
        child: SingleChildScrollView(
          child: Stack(
            children: [
              //curved widget made for design purpose
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
                        Color(0xff4ca5b5),
                        Colors.white.withOpacity(0.95)
                      ],
                    ),
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
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(top: 250),
                  child: Column(
                    children: [
                      //Container for email textfield
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
                      //Container for password textfield
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
                      //sign in button
                      Container(
                        width: 180,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          //call for data controller to search for email in database
                          child: GetBuilder<DataController>(
                            init: DataController(),
                            builder: (val) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 4,
                                  primary: Color(0xFF4ca5b5), // background
                                  onPrimary: Colors.white, // foreground
                                ),
                                onPressed: () {
                                  //check if email has been entered
                                  if (emailInputController.text.isNotEmpty) {
                                    //check if password has been entered
                                    if (passwordInputController
                                        .text.isNotEmpty) {
                                      val
                                          .emailQueryData(
                                              emailInputController.text)
                                          .then(
                                        (value) {
                                          snapshotData = value;
                                          //check if email exist in database
                                          if (snapshotData.docs.isNotEmpty) {
                                            context
                                                .read<AuthenticationService>()
                                                .signIn(
                                                  email: emailInputController
                                                      .text
                                                      .trim(),
                                                  password:
                                                      passwordInputController
                                                          .text
                                                          .trim(),
                                                );
                                          } else {
                                            //snackbar for when incorrect email or password is entered
                                            final snackBar = SnackBar(
                                              content: Text(
                                                  'Incorrect Email or Password!'),
                                              duration:
                                                  Duration(milliseconds: 1000),
                                              backgroundColor:
                                                  Color(0xFFe62d11),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                        },
                                      );
                                      
                                    } else {
                                      //snackbar for when email is not entered
                                      final snackBar = SnackBar(
                                        content: Text('Password not entered'),
                                        duration: Duration(milliseconds: 1000),
                                        backgroundColor: Color(0xFFe62d11),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  } else {
                                    final snackBar = SnackBar(
                                      content: Text('Email not entered'),
                                      duration: Duration(milliseconds: 1000),
                                      backgroundColor: Color(0xFFe62d11),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                child: Text("LOGIN"),
                              );
                            },
                          ),
                        ),
                      ),
                      //register button
                      Container(
                        width: 180,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ),
                              );
                            },
                            child: Text("REGISTER"),
                            style: OutlinedButton.styleFrom(
                              primary: Color(0xFF4ca5b5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
