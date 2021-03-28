import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:youth_food_movement/Franks%20stuff/YFMHomePage.dart';
import 'package:youth_food_movement/login/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youth_food_movement/login/register_page.dart';
//import 'package:youth_food_movement/recipe/ui/ingredients_page.dart';

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

    if (firebaseUser != null) {
      return YFMHomePage();
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
                  context.read<AuthenticationService>().signIn(
                        email: "test@gmail.com",
                        password: "test123",
                        // email: emailInputController.text.trim(),
                        //password: passwordInputController.text.trim(),
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
