import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:youth_food_movement/login/login_page.dart';
import 'package:youth_food_movement/login/user_detail_page.dart';
import 'package:youth_food_movement/login/curved_widget.dart';
import 'authentication_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //controllers for text fields
  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();

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
                    'Just Cook Register',
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
                      Container(
                        width: 200,
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(labelText: "Email"),
                          controller: emailInputController,
                        ),
                      ),
                      Container(
                        width: 200,
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "6 letters+"
                          ),
                          controller: passwordInputController,
                          obscureText: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: ElevatedButton(
                          onPressed: () {
                            //check if email has been entered
                            if (emailInputController.text.isNotEmpty) {
                              //check if password has been entered
                              if (passwordInputController.text.isNotEmpty) {
                                //check if password is longer than 6 letters
                                if(passwordInputController.text.length >= 6) {
                                  //signup account with entered email and password if both are entered
                                  context.read<AuthenticationService>().signUp(
                                    email: emailInputController.text.trim(),
                                    password:
                                    passwordInputController.text.trim(),
                                  );
                                  //move to next page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserDetailPage()),
                                  );
                                } else {
                                  final snackBar = SnackBar(
                                    content: Text('Password is not 6 letters or longer'),
                                    duration: Duration(milliseconds: 1000),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              } else {
                                final snackBar = SnackBar(
                                  content: Text('Password not entered'),
                                  duration: Duration(milliseconds: 1000),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            } else {
                              final snackBar = SnackBar(
                                content: Text('Email not entered'),
                                duration: Duration(milliseconds: 1000),
                                backgroundColor: Colors.red,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: Text("Next"),
                        ),
                      ),
                      //button to cancel registration and go back to login page
                      Padding(
                        padding: const EdgeInsets.only(top:12.0),
                        child: ElevatedButton(
                          onPressed: () {
                            final snackBar = SnackBar(
                              content: Text('Register Cancelled'),
                              duration: Duration(milliseconds: 1000),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LogIn()),
                            );
                          },
                          child: Text("Back"),
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
}
