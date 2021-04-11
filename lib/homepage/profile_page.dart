import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youth_food_movement/bookmark/bookmarks.dart';
import 'package:youth_food_movement/recipe_submission/ui/recipe_submit_info.dart';
import 'package:youth_food_movement/homepage/settings_page.dart';
import 'package:url_launcher/url_launcher.dart';

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
              //a temp holder for the users icon.
              child: Icon(FontAwesomeIcons.userGraduate,
                  size: 120, color: Colors.red),
            ),
            ProfileButtons(),
          ])),
    );
  }
}

//this class creates 4 raw material buttons to navigate to the multiple areas of the app
class ProfileButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, left: 3.0, right: 3.0),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 90,
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
                  padding: EdgeInsets.all(10),
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  child: Icon(
                    FontAwesomeIcons.cogs,
                    size: 40,
                    color: Colors.red,
                  ),
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SettingPage()))
                      }),
              RawMaterialButton(
                padding: EdgeInsets.all(10),
                fillColor: Colors.white,
                shape: CircleBorder(),
                child:
                    Icon(FontAwesomeIcons.globe, size: 40, color: Colors.red),
                onPressed: _launchURL,
              ),
              RawMaterialButton(
                  padding: EdgeInsets.all(10),
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  child: Icon(FontAwesomeIcons.solidBookmark,
                      size: 40, color: Colors.red),
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    BookmarkedRecipeThumbnail()))
                      }),
              RawMaterialButton(
                  padding: EdgeInsets.all(11),
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  child: Icon(FontAwesomeIcons.plusCircle,
                      size: 40, color: Colors.red),
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    InformationSubmission()))
                      }),
            ],
          ),
        ),
      ),
    );
  }
}

//this code allows the user to access the just cook about us page.
_launchURL() async {
  const url = 'http://justcook.co.nz/about-us';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
