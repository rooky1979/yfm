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
      backgroundColor: background,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[gradientColourA, gradientColourB],
            ),
          ),
        ),
        title: Text(
          'Profile Information',
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
