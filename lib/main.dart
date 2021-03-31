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
/*import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Open Url Example',
      home: OpenUrlExample(),
    );
  }
}

class OpenUrlExample extends StatelessWidget {
  const OpenUrlExample({Key key}) : super(key: key);

  _launchURL() async {
  const url = 'https://flutter.dev';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Open Url flutter example')),
      body: Center(
      child: RaisedButton(
        onPressed: _launchURL,
        child: Text('Show Flutter homepage'),
      ),
    ),
    );
  }
}*/
