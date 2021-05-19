import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:youth_food_movement/bookmark/bookmark_page.dart';
import 'package:youth_food_movement/colours/hex_colours.dart';
import 'package:youth_food_movement/homepage/home_page.dart';
import 'package:youth_food_movement/homepage/profile_page.dart';
import 'package:youth_food_movement/login/login_page.dart';
import 'package:youth_food_movement/login/register_page.dart';
import 'package:youth_food_movement/login/user_detail_page.dart';
import 'package:youth_food_movement/recipe_submission/ui/recipe_submit_image.dart';
import 'package:youth_food_movement/recipe_submission/ui/recipe_submit_info.dart';
import 'package:youth_food_movement/recipe_submission/ui/recipe_submit_ingredients.dart';
import 'package:youth_food_movement/recipe_submission/ui/recipe_submit_method.dart';
import 'package:youth_food_movement/recipe_submission/ui/recipe_submit_success.dart';

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
