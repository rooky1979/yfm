import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DBControl {
  //static variables used in recipe_info_submission
  //value used for dropdown selection in dropdown menus
  static var categoryValue;
  static var difficultyValue;
  //value used for the checkboxes
  static List allergies;
  static List proteins;
  //text controllers for the textfields
  static TextEditingController recipeNameController;
  static TextEditingController servingsController;
  static TextEditingController hoursController;
  static TextEditingController minutesController;
  static TextEditingController descriptionController;
  static int prepTime;

  //static list to hold ingredient strings for recipe_ingredients_submission
  static List ingredients = [];

  //recipe_method_submission static variables
  //list to hold ingredient strings
  static List methodSteps = [];

  //recipe_image_submission static variables
  static File image;
  static String docID;
  static String recipeID;

//static method that writes to the DB
  static void writeDB() async {
    //firebase instance declaration
    var recipeDocRef =
        await FirebaseFirestore.instance.collection('recipe').add({});
    //write to the recipe table ingredients subcollection instance
    await recipeDocRef.collection("ingredients").add({
      "difficulty": difficultyValue,
      "allergies": allergies,
      "category": categoryValue,
      "description": descriptionController.text,
      "image": recipeDocRef.id,
      "ingredients": ingredients,
      "prepTime": prepTime,
      "protein": proteins,
      "servings": servingsController.text,
      "title": recipeNameController.text
    });
    //write the recipe table method subcollection instance
    await recipeDocRef.collection("method").add({"method": methodSteps});
    //upload image to firebase storage
    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('recipe_images/' + recipeDocRef.id);
    print(recipeDocRef.id.toString());
    UploadTask uploadTask = firebaseStorageRef.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
  }

  //method to clear the controllers and variables if a user clicks on cancel at anytime or clicks finished
  //performs if statements to see if any of the variables are not empty
  //if any of the variables are empty, nothing happens
  static void clearDBVariables() {
    // ignore: unnecessary_statements
    if (categoryValue != null) categoryValue;
    // ignore: unnecessary_statements
    if (difficultyValue != null) difficultyValue;
    if (allergies != null) allergies.clear();
    if (proteins != null) proteins.clear();
    if (recipeNameController.text.isNotEmpty) recipeNameController.clear();
    if (servingsController.text.isNotEmpty) servingsController.clear();
    if (hoursController.text.isNotEmpty) hoursController.clear();
    if (minutesController.text.isNotEmpty) minutesController.clear();
    if (descriptionController.text.isNotEmpty) descriptionController.clear();
    if (prepTime != null) prepTime = null;
    if (ingredients != null) ingredients.clear();
    if (methodSteps != null) methodSteps.clear();
    if (image != null) image = null;
  }

  //helper method to pop the required amount of pages off when cancel is pressed
  static void popPage(int popAmount, BuildContext context) {
    for (int i = 0; i < popAmount; ++i) {
      Navigator.pop(context);
    }
  }
}
