import 'package:youth_food_movement/homepage/Category1.dart';
import 'package:youth_food_movement/homepage/Category2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:youth_food_movement/homepage/profile_page.dart';
import 'package:youth_food_movement/recipe/ui/recipe_controls_page.dart';

class YFMHomePage extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<YFMHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Container(
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5.0),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.zero)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Recipe",
                      hintStyle: TextStyle(color: Colors.white),
                      icon: Icon(Icons.list, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecipeControlsPage()),
                          );
                        },
                        icon: Icon(Icons.search),
                      ),
                    ],
                  ),
                )
              ],
            )),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              icon: Icon(Icons.search_off)),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Category1(),
          Category2(),
          // Category3()
        ],
      ),
    );
  }
}
// Container(
//   height: 250.0,
//   margin: EdgeInsets.all(10.0),
//   child: ListView(
//     scrollDirection: Axis.horizontal,
//     children: <Widget>[
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Title(color: Colors.black, child: Text("Category 1")),
//       ),
//       Column(
//         children: [
//           Container(
//               margin: EdgeInsets.all(10.0),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(17.0),
//                 child: Image(
//                   image: AssetImage("assets/a.jpg"),
//                   height: 200.0,
//                   width: 200.0,
//                   fit: BoxFit.cover,
//                 ),
//               )),
//         ],
//       ),
//     Container(
//           margin: EdgeInsets.all(10.0),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(17.0),
//             child: Image(
//               image: AssetImage("assets/b.jpg"),
//               height: 200.0,
//               width: 200.0,
//               fit: BoxFit.cover,
//             ),
//       )),
//       SizedBox(
//         height: 5.0,
//       ),
