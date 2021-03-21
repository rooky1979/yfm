import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youth_food_movement/login/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youth_food_movement/login/register_page.dart';

import '../recipe/ui/ingredients_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
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
  const AuthenticationWrapper({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if(firebaseUser != null){
      return IngredientsPage();
    }
    return LogIn();
  }
}

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
                  "Just Cook Login",
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
                  decoration: InputDecoration(labelText: "Email"),
                  controller: emailInputController,
                ),
              ),
              Container(
                width: 200,
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(labelText: "Password"),
                  controller: passwordInputController,
                  obscureText: true,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationService>().signIn(
                    email: emailInputController.text.trim(),
                    password: passwordInputController.text.trim(),
                  );
                },
                child: Text("Login"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
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