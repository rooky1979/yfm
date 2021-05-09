import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:youth_food_movement/homepage/home_page.dart';
import 'package:youth_food_movement/homepage/profile_page.dart';
import 'package:youth_food_movement/homepage/settings_page.dart';
import 'package:youth_food_movement/recipe/ui/ingredients_page.dart';
import 'package:youth_food_movement/homepage/test_homepage.dart';
import 'package:youth_food_movement/recipe_submission/ui/recipe_submit_info.dart';
import 'package:youth_food_movement/recipe_submission/ui/recipe_submit_ingredients.dart';
import 'package:youth_food_movement/login/login_page.dart';

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
      home: HomePage(),
      //home: TestHomepage(),
    ),
  );
}
