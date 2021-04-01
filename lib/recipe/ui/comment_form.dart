import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//import 'package:firebase_core/firebase_core.dart';
//import 'dart:math';

class CommentEntryDialog extends StatefulWidget {
  @override
  _CommentEntryDialogState createState() => _CommentEntryDialogState();
}

class _CommentEntryDialogState extends State<CommentEntryDialog> {
  //database connection to the board firebase
  var firestoreDb = FirebaseFirestore.instance.collection('board').snapshots();
  CollectionReference imgRef;
  firebase_storage.Reference ref;
  //controllers for the editable text fields
  TextEditingController nameInputController;
  TextEditingController titleInputController;
  TextEditingController descriptionInputController;

  @override
  void initState() {
    super.initState();
//initialise and instantiate the text controllers
    nameInputController = TextEditingController();
    titleInputController = TextEditingController();
    descriptionInputController = TextEditingController();
  }

  File _imgfile;
  final imagePicker = ImagePicker();
  String imgAttached = "false";
  var url;

  _openGallery(BuildContext context) async {
    final imgfile = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _imgfile = File(imgfile.path);
      //debugPrint(_imgfile.path.toString());
      imgAttached = "true";
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    final imgfile = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _imgfile = File(imgfile.path);
      // debugPrint(_imgfile.path.toString());
    });
    Navigator.of(context).pop();
  }

  Future _uploadImageToFirebase(String commentId) async {
    if (_imgfile != null) {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('/images/' + commentId);
      await ref.putFile(_imgfile).whenComplete(() async {
        await ref.getDownloadURL().then((value) {});
      });
      //debugPrint("Download URL" + ref.getDownloadURL().toString());
    }
  }

  // Future<void> _addPathToDatabase(String text) async {
  //   try {
  //     // Get image URL from firebase
  //     final ref = FireStorage().ref().child(text);
  //     var imageString = await ref.getDownloadURL();

  //     // Add location and url to database
  //     await Firestore.instance.collection('storage').document().setData({'url':imageString , 'location':text});
  //   }catch(e){
  //     print(e.message);
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             content: Text(e.message),
  //           );
  //         }
  //     );
  //   }
  // }

  Widget _decideImageView() {
    //debugPrint(_imgfile.path.toString());
    if (_imgfile == null) {
      return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(2)),
              width: double.infinity,
              child: Row(children: [
                Icon(
                  Icons.image,
                  size: 85,
                ),
                VerticalDivider(
                  thickness: 2,
                ),
                TextButton(
                    onPressed: () {
                      _showChoiceDialog(context);
                    },
                    child: Text("Add An Image", style: TextStyle(fontSize: 18)))
              ]),
            ),
          ],
        ),
      );
    } else {
      setState(() {});
      return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(2)),
              width: double.infinity,
              child: IntrinsicHeight(
                child: Row(children: [
                  FittedBox(
                    child: Image.file(
                      _imgfile,
                      fit: BoxFit.cover,
                      height: 85,
                      width: 85,
                    ),
                  ),
                  Container(
                    width: 10,
                    //height: 4,
                    color: Colors.black38,
                  ),
                  VerticalDivider(
                    thickness: 4,
                    width: 1,
                  ),
                  TextButton(
                      onPressed: () {
                        _showChoiceDialog(context);
                      },
                      child:
                          Text("Change Image", style: TextStyle(fontSize: 18)))
                ]),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice!"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 0),
        child: Column(
          children: [
            Text(
              'Comment',
              style: TextStyle(fontSize: 20),
            ),
            Divider(thickness: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    //button to cancel the comment and clear the textfields
                    onPressed: () {
                      nameInputController.clear();
                      //titleInputController.clear();
                      descriptionInputController.clear();
                      Navigator.pop(context);
                    },
                    padding: const EdgeInsets.only(right: 120),
                    icon: Icon(Icons.clear),
                    iconSize: 30),
                IconButton(
                    //button to save the comment to the database
                    onPressed: () {
                      print(imgAttached);
                      if (descriptionInputController.text.isNotEmpty) {
                        FirebaseFirestore.instance.collection('board').add({
                          'user': "Temp Name 2",
                          'title': "Temp Title",
                          'imgAttached': imgAttached,
                          'description': descriptionInputController.text,
                          'timestamp': new DateTime.now(),
                          'image_url': url,
                          'likes': 0,
                          'likedUsers': [],
                        }).then((response) {
                          print(response.id);
                          if (imgAttached == "true") {
                            _uploadImageToFirebase(response.id);
                          }

                          final snackBar = SnackBar(
                            content: Text('Comment Posted'),
                            duration: Duration(milliseconds: 1000),
                            backgroundColor: Colors.green,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pop(context);
                          nameInputController.clear();
                          titleInputController.clear();
                          descriptionInputController.clear();
                          _imgfile = null;
                          imgAttached = "false";
                        }).catchError((onError) => print(onError));
                      }
                    },
                    padding: const EdgeInsets.only(left: 120),
                    icon: Icon(Icons.check),
                    iconSize: 30)
              ],
            ),
            SizedBox(height: 15),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 15,
                maxLines: 20,
                autofocus: true,
                autocorrect: true,
                decoration: InputDecoration(
                    hintText: 'A Question, Comment, or Tip!',
                    labelText: 'Type Here...',
                    labelStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 17,
                    ),
                    border: const OutlineInputBorder()),
                controller: descriptionInputController,
              ),
            ),
            SizedBox(height: 20),
            _decideImageView(),
          ],
        ),
      ),
    );
  }
}
