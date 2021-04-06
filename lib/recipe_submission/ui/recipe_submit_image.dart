import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageSubmission extends StatefulWidget {
  @override
  _ImageSubmissionState createState() => _ImageSubmissionState();
}

class _ImageSubmissionState extends State<ImageSubmission> {
  // Image Picker
  File _image; // Used only if you need a single picture

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

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path); // Use if you only need a single picture
      } else {
        print('No image selected.');
      }
    });
  }

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
              //Container(child: Image.file(_image))
            ],
          )),
    );
  }
}
