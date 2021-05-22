import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:youth_food_movement/colours/hex_colours.dart';
import 'package:youth_food_movement/login/login_page.dart';
import 'package:youth_food_movement/login/user_detail_page.dart';
import 'package:youth_food_movement/login/user_info.dart';
import 'package:youth_food_movement/recipe_submission/ui/recipe_submit_success.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    new MaterialApp(
      theme: ThemeData(
        primaryColor: background,
      ),
      home: LoginPage(),
    ),
  );
}
