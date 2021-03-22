import 'package:flutter/material.dart';

class Category2 extends StatelessWidget {
  List<_Category2Photo> _category1() {
    return [
      _Category2Photo(
          imageURL:
              'https://www.google.com/search?q=food&rlz=1C1CHZN_zh-CNNZ929NZ929&sxsrf=ALeKk02XwDiigE-2iHg-sZYjUwY-chVs2w:1615704996390&source=lnms&tbm=isch&biw=1368&bih=770#imgrc=sPBhlA8_u01kFM',
          title: 'food',
          subtitle: 'owner',
          recipe: 'Category1'),
      // _Category2Photo(imageURL: 'https://cdn.pixabay.com/photo/2011/09/27/18/52/sparrow-9950_960_720.jpg',
      //     title: 'Loud bird',
      //     subtitle: 'sometimes the bird is loud',
      //     recipe: 'Feature2'),
      // _Category2Photo(imageURL: 'https://cdn.pixabay.com/photo/2016/12/04/21/58/rabbit-1882699_960_720.jpg',
      //     title: 'Rabit',
      //     subtitle: 'She is cute',
      //     recipe: 'Feature3'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 320,
        width: 220,
        child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(10.0),
            children: _category1().map<Widget>((photo) {
              return _Category2Item(category1Photo: photo); //Feature(photo);
            }).toList()));
  }
}

class _Category2Photo {
  _Category2Photo({this.imageURL, this.title, this.subtitle, this.recipe});
  final String imageURL;
  final String title;
  final String subtitle;
  final String recipe;
}

// text under the image
class _Category2Text extends StatelessWidget {
  const _Category2Text(this.text, this.fontSize);
  final String text;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 14),
      child: Text(text,
          style:
              TextStyle(fontFamily: 'ConcertOne-Regular', fontSize: fontSize)),
    );
  }
}

class _Category2Item extends StatelessWidget {
  _Category2Item({Key key, @required this.category1Photo}) : super(key: key);

  final _Category2Photo category1Photo;
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            //adding text and image
            child: Stack(
              children: <Widget>[
                Image.network(category1Photo.imageURL,
                    width: 230, height: 230, fit: BoxFit.cover),
                //text in the photo
                Positioned(
                    top: 16,
                    left: 140,
                    child: Container(
                      height: 25,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Colors.black, //Color(0xff0F0F0F),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                            )
                          ]),
                      child: Center(
                        child: Text(
                          category1Photo.recipe,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ))
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 5,
            margin: EdgeInsets.all(10),
          ),
          _Category2Text(category1Photo.title, 16),
          _Category2Text(category1Photo.subtitle, 12),
        ]);
  }
}
