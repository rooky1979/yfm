import 'package:flutter/material.dart';

@override
Widget build(BuildContext context) {
  return Center();
}

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: new Color(0xFFf0f1eb),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Profile Information',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
      ),
    );
  }
}
