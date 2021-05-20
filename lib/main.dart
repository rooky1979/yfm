import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:youth_food_movement/colours/hex_colours.dart';
import 'package:youth_food_movement/login/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    new MaterialApp(
      //theme: _appTheme,
      theme: ThemeData(
        //brightness: Brightness.light,
        primaryColor: cream,
      ),
      home: LoginPage(),
    ),
  );
}
