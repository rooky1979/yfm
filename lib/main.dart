import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:youth_food_movement/homepage/profile_page.dart';
import 'package:youth_food_movement/recipe/ui/ingredients_page.dart';
import 'package:youth_food_movement/recipe_submission/ui/recipe_submit_info.dart';
import 'login/login_page.dart';
import 'recipe/ui/test_homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    new MaterialApp(
      //theme: _appTheme,
      theme: ThemeData(
        //brightness: Brightness.light,
        primaryColor: Colors.red[300],
        /* textTheme: TextTheme(

            headline5: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            bodyText1: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(
                fontSize: 25,
                color: Colors.white,*/
      ),
<<<<<<< HEAD
      home: LoginPage(),
=======

      home: TestHomepage(),

>>>>>>> 118181220700cbed8f6f821c6fd6338236dd304e
    ),
  );
}
