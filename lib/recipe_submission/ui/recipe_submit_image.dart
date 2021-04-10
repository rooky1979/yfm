import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youth_food_movement/recipe_submission/network/db_control.dart';
import 'package:youth_food_movement/recipe_submission/ui/recipe_submit_success.dart';

class ImageSubmission extends StatefulWidget {
  @override
  _ImageSubmissionState createState() => _ImageSubmissionState();
}

class _ImageSubmissionState extends State<ImageSubmission> {
  // Image Picker
  File _image;
//method to get the image
  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;
    // Let user select photo from gallery
    if (gallery) {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,
      );
    }
    // Otherwise open camera to get new photo
    else {
      pickedFile = await picker.getImage(
        source: ImageSource.camera,
      );
    }
//set the state of the container
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

//snackbar for if no image is selected
  var snackbar = SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: Colors.blue[600],
      content: Text("Please select an image",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          )));

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
        title: Text('Upload an image!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //button to pick image from gallery
                    Column(
                      children: [
                        RawMaterialButton(
                          fillColor: Colors.red[400],
                          child: Icon(
                            FontAwesomeIcons.solidImage,
                            size: 40,
                            color: Colors.white,
                          ),
                          elevation: 8,
                          onPressed: () {
                            getImage(true);
                          },
                          padding: EdgeInsets.all(15),
                          shape: CircleBorder(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Camera Roll',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ],
                    ),
                    //button to open and use the camera
                    Column(
                      children: [
                        RawMaterialButton(
                          fillColor: Colors.red[400],
                          child: Icon(
                            FontAwesomeIcons.camera,
                            size: 40,
                            color: Colors.white,
                          ),
                          elevation: 8,
                          onPressed: () {
                            getImage(false);
                          },
                          padding: EdgeInsets.all(15),
                          shape: CircleBorder(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Take photo',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //buttons to cancel the submission and finish
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.white),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          DBControl.clearDBVariables();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        child: Text(
                          'Finish',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (_image == null) {
                            //snackbar shown if any of the fields are empty
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } else {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SuccessSubmission()));
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Recipe image preview:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: _image == null
                        ? Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                                child: Text(
                              'No Image Selected',
                              textAlign: TextAlign.center,
                            )),
                          )
                        : Image.file(_image),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
