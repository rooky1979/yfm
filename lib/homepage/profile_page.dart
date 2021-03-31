import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:youth_food_movement/login/authentication_service.dart';
import 'package:youth_food_movement/recipe/ui/recipe_controls_page.dart';
import 'package:youth_food_movement/recipe_submission/ui/recipe_submit_info.dart';
import 'package:youth_food_movement/settings/settings_page.dart';

@override
Widget build(BuildContext context) {
  return Center();
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              size: 25,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Profile Navigation Page',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Card(
              child: Icon(FontAwesomeIcons.userGraduate, //comments button
                  size: 120,
                  color: Colors.red),
            ),
            ProfileButtons(),
          ])),
    );
  }
}

class ProfileButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, left: 3.0, right: 3.0),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 90,
        //color: Colors.red[400],
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.red[400],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RawMaterialButton(
                  padding: EdgeInsets.all(10), //ingredients button
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  child: Icon(
                    FontAwesomeIcons.cogs,
                    size: 40,
                    color: Colors.red,
                  ),
                  onPressed: () => {
                        //pops any page currently loaded off the stack and pushes the required page onto the stack
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SettingPage()))
                      }),
              RawMaterialButton(
                  // recipe method button
                  padding: EdgeInsets.all(10),
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  child:
                      Icon(FontAwesomeIcons.globe, size: 40, color: Colors.red),
                  onPressed: () => {
                        //pops any page currently loaded off the stack and pushes the required page onto the stack
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    InformationSubmission(null)))
                      }),
              RawMaterialButton(
                  padding: EdgeInsets.all(11),
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  child: Icon(FontAwesomeIcons.plusCircle, //comments button
                      size: 40,
                      color: Colors.red),
                  onPressed: () => {
                        //pops any page currently loaded off the stack and pushes the required page onto the stack
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    InformationSubmission(null)))
                      })
            ],
          ),
        ),
      ),
    );
  }
}
