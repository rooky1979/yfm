import 'package:flutter/material.dart';
import 'package:youth_food_movement/colours/hex_colours.dart';

@override
Widget build(BuildContext context) {
  return Center();
}

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: linen,
      appBar: AppBar(
        backgroundColor: orangeRed,
        title: Text(
          'Profile Information',
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
