import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youth_food_movement/homepage/HomePage.dart';
import 'package:youth_food_movement/login/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youth_food_movement/login/curved_widget.dart';
import 'package:youth_food_movement/login/register_page.dart';
import 'package:youth_food_movement/recipe/ui/test_homepage.dart';

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
      return TestHomepage();
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
<<<<<<< Updated upstream
                        padding: const EdgeInsets.only(top: 12.0),
=======

                        padding: const EdgeInsets.only(top:12.0),

>>>>>>> Stashed changes
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AuthenticationService>().signIn(
                                  email: emailInputController.text.trim(),
                                  password: passwordInputController.text.trim(),
                                );
                          },
                          child: Text("Login"),
                        ),
                      ),
                      //register account button
                      Padding(
<<<<<<< Updated upstream
                        padding: const EdgeInsets.only(top: 12.0),
=======

                        padding: const EdgeInsets.only(top:12.0),
>>>>>>> Stashed changes
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
