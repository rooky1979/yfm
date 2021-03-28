import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'login/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
    //theme: _appTheme,
    theme: ThemeData(
      //brightness: Brightness.light,
      primaryColor: Colors.red[300],
      /* textTheme: TextTheme(
            headline5: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            bodyText1: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold)) */
    ),
    home: LoginPage(),
  ));
}
