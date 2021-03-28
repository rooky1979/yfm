import 'package:flutter/material.dart';

@override
Widget build(BuildContext context) {
  return Center();
}

class SubmissionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Card(
              child: Container(
                width: 400.0,
                height: 400.0,
                decoration: new BoxDecoration(),
                child: new Text('Temp submission page'),
              ),
            ),
          ])),
    );
  }
}
