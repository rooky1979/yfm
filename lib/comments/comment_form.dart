import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:youth_food_movement/colours/hex_colours.dart';

class CommentEntryDialog extends StatefulWidget {
  @override
  _CommentEntryDialogState createState() => _CommentEntryDialogState();
  const CommentEntryDialog({Key key, this.recipeID}) : super(key: key);
  final String recipeID;
}

class _CommentEntryDialogState extends State<CommentEntryDialog> {
  CollectionReference imgRef;
  firebase_storage.Reference ref;
  //controllers for the editable text field
  TextEditingController descriptionInputController;
  @override
  void initState() {
    super.initState();
//initialise and instantiate the text controller
    descriptionInputController = TextEditingController();
  }

  File _imgfile;
  final imagePicker = ImagePicker();
  bool imgAttached = false;
  var url;
// This method opens the gallery and saves the file path/sets the image attached string to true
  _openGallery(BuildContext context) async {
    final imgfile = await imagePicker.getImage(source: ImageSource.gallery);
    setState(
      () {
        _imgfile = File(imgfile.path);
        imgAttached = true;
        debugPrint(_imgfile.path);
      },
    );
    Navigator.of(context).pop();
  }

  //This method opens the camera and saves the file path/sets the image attached string to true
  _openCamera(BuildContext context) async {
    final imgfile = await imagePicker.getImage(source: ImageSource.camera);
    setState(
      () {
        _imgfile = File(imgfile.path);
        imgAttached = true;
      },
    );
    Navigator.of(context).pop();
  }

// This method adds the image to the firebase storage with the same ID as the newly created comment.
  Future _uploadImageToFirebase(String commentId) async {
    if (_imgfile != null) {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('/comment_images/' + commentId);
      await ref.putFile(_imgfile).whenComplete(
        () async {
          await ref.getDownloadURL().then(
                (value) {},
              );
        },
      );
    }
  }

// This widget creates the image button, if an image is attached it shows the image, and changes the text to "Change image"
// It also calls the _showChoiceDialog alert box when the button is pressed.
  Widget _decideImageView() {
    if (_imgfile == null) {
      return Container(
        decoration: BoxDecoration(
          //border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(2),
        ),
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            _showChoiceDialog(context);
          },
          icon: Icon(
            Icons.image,
            size: 25,
          ),
          label: Text(
            "Add Image",
            style: TextStyle(fontSize: 25),
          ),
        ),
      );
    } else {
      setState(() {});
      return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
              width: double.infinity,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FittedBox(
                      child: Image.file(
                        _imgfile,
                        fit: BoxFit.cover,
                        height: 125,
                        width: 85,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        _showChoiceDialog(context);
                      },
                      icon: Icon(
                        Icons.image,
                        size: 25,
                      ),
                      label: Text(
                        "Change Image",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(padding: EdgeInsets.all(6.0))
          ],
        ),
      );
    }
  }

  // This method creates an AlertDialog which allows the user to pick between gallery and camera for the image source.
  // Once picked either _openGallery or _openCamera are called.
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
      },
    );
  }

//This is the main widget that has the body of the comment Form
//It contains the text entry field, button to cancel and send the comment,
//and image add button.
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final filter = ProfanityFilter();
    String recipeID = widget.recipeID;
    return Scaffold(
      backgroundColor: cream,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
        child: Column(
          children: [
            Text(
              'Comment',
              style: TextStyle(
                fontSize: 20,
                color: darkPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(thickness: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    //button to cancel the comment and clear the textfields
                    onPressed: () {
                      descriptionInputController.clear();
                      Navigator.pop(context);
                    },
                    padding: const EdgeInsets.all(20),
                    icon: Icon(Icons.clear),
                    iconSize: 30),
                IconButton(
                    //button to save the comment to the database
                    onPressed: () {
                      if (!filter
                          .hasProfanity(descriptionInputController.text)) {
                        if (descriptionInputController.text.isNotEmpty) {
                          final snackBar = SnackBar(
                            content: Text('Comment Posted'),
                            duration: Duration(milliseconds: 8000),
                            backgroundColor: green,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          FirebaseFirestore.instance
                              .collection('recipe')
                              .doc('$recipeID')
                              .collection('comments')
                              .add(
                            {
                              'user': _firebaseAuth.currentUser.uid,
                              'uid': _firebaseAuth.currentUser.uid,
                              'imgAttached': imgAttached,
                              'description': descriptionInputController.text,
                              'timestamp': new DateTime.now(),
                              'likes': 0,
                              'likedUsers': [],
                              'reported': false
                            },
                          ).then(
                            (response) {
                              print(response.id);
                              if (imgAttached == true) {
                                _uploadImageToFirebase(response.id);
                              }
                              final snackBar = SnackBar(
                                content: Text('Comment Posted'),
                                duration: Duration(milliseconds: 1000),
                                backgroundColor: greenSheen,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.pop(context);
                              descriptionInputController.clear();
                              _imgfile = null;
                              imgAttached = false;
                            },
                          ).catchError(
                            (onError) => print(onError),
                          );
                        } else {
                          final snackBar = SnackBar(
                            content: Text('Please Write Your Comment...'),
                            duration: Duration(milliseconds: 1000),
                            backgroundColor: orangeRed,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } else {
                        final snackBar = SnackBar(
                          content: Text('Please use appropriate language'),
                          duration: Duration(milliseconds: 1000),
                          backgroundColor: orangeRed,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                minLines: 30,
                maxLines: 60,
                autofocus: true,
                autocorrect: true,
                decoration: InputDecoration(
                  hintText: 'A Question, Comment, or Tip!',
                  labelText: 'Type Here...',
                  labelStyle: TextStyle(
                    color: orangeRed,
                    fontSize: 17,
                  ),
                  border: const OutlineInputBorder(),
                ),
                controller: descriptionInputController,
              ),
            ),
            SizedBox(height: 15),
            _decideImageView(),
          ],
        ),
      ),
    );
  }
}
