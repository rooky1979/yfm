import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'authentication_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Just Cook Register",
                  style: TextStyle(
                    fontSize: 40,
                    //background image
                  ),
                ),
              ),
              Container(
                width: 200,
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(labelText: "Username"),
                  controller: emailInputController,
                ),
              ),
              Container(
                width: 200,
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(labelText: "Password"),
                  controller: passwordInputController,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationService>().signUp(
                        email: emailInputController.text.trim(),
                        password: passwordInputController.text.trim(),
                      );
                },
                child: Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
