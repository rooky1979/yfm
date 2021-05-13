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
        backgroundColor: new Color(0xFFe62d11),
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
