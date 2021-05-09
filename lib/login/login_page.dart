import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:youth_food_movement/homepage/HomePage.dart';
import 'package:youth_food_movement/login/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youth_food_movement/login/curved_widget.dart';
import 'package:youth_food_movement/login/register_page.dart';
import 'package:youth_food_movement/recipe/ui/test_homepage.dart';

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
      return TestHomePage();
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
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
                  child: Text(
                    'Just Cook Login',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(top: 230),
                  child: Column(
                    children: [
                      //Container for email textfield
                      Container(
                        width: 200,
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(labelText: "Email"),
                          controller: emailInputController,
                        ),
                      ),
                      //Container for password textfield
                      Container(
                        width: 200,
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(labelText: "Password"),
                          controller: passwordInputController,
                          obscureText: true,
                        ),
                      ),
                      //sign in button
                      Padding(

                        padding: const EdgeInsets.only(top:12.0),
                        child: GetBuilder<DataController>(
                            init: DataController(),
                            builder: (val) {
                              return ElevatedButton(
                                  onPressed: () {
                                    //check if email has been entered
                                    if(emailInputController.text.isNotEmpty) {
                                      //check if password has been entered
                                      if(passwordInputController.text.isNotEmpty) {
                                        val.emailQueryData(emailInputController.text).then((value) {
                                          snapshotData = value;
                                          //check if email exist in database
                                          if(snapshotData.docs.isNotEmpty) {
                                            context.read<AuthenticationService>().signIn(
                                              email: emailInputController.text.trim(),
                                              password: passwordInputController.text.trim(),
                                            );
                                          }else {
                                            final snackBar = SnackBar(
                                              content: Text('Email does not exist'),
                                              duration: Duration(milliseconds: 1000),
                                              backgroundColor: Colors.red,
                                            );
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                          }
                                        });
                                      } else {
                                        final snackBar = SnackBar(
                                          content: Text('Password not entered'),
                                          duration: Duration(milliseconds: 1000),
                                          backgroundColor: Colors.red,
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                    } else {
                                      final snackBar = SnackBar(
                                        content: Text('email not entered'),
                                        duration: Duration(milliseconds: 1000),
                                        backgroundColor: Colors.red,
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                  },
                                  child: Text("Login"),
                                  );
                            }),
                      ),
                      //register account button
                      Padding(

                        padding: const EdgeInsets.only(top:12.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            );
                          },
                          child: Text("Register"),
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
