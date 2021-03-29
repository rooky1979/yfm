import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:youth_food_movement/recipe_submission/ui/recipe_submit_info.dart';

import 'login/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.red[300],
    ),
    home: LoginPage(),
  ));
}
