import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DBControl {
  //recipe_info
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

  //list to hold ingredient strings
  static List ingredients = []; 

  //recipe_method
  //list to hold ingredient strings
  static List methodSteps = [];

  //recipe_image
  static File image;
  //something in here to change the
  //string name or apply the recipe doc name ID???

  //declare and instantiate the firebase storage bucket
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: 'gs://youth-food-movement.appspot.com');
  //firebase instance
  static var firestoreDb =
      FirebaseFirestore.instance.collection('recipe').snapshots();

  static void writeDB() async {
    var recipeDocRef =
        await FirebaseFirestore.instance.collection('recipe').add({});

    await recipeDocRef.collection("ingredients").add({
      "difficulty": difficultyValue,
      "allergies": allergies,
      "category": categoryValue,
      "description": descriptionController.text,
      "image": "testing",
      "ingredients": ingredients,
      "prepTime": prepTime,
      "protein": proteins,
      "servings": servingsController.text,
      "title": recipeNameController.text
    });
    await recipeDocRef.collection("method").add({"method": methodSteps});
  }
  //method to clear the controllers and variables if a user clicks on cancel at anytime
  static void clearDBVariables(){

    categoryValue == null; 
    difficultyValue == null;
    allergies.clear(); 
    proteins.clear();
    recipeNameController.clear(); 
    servingsController.clear(); 
    hoursController.clear();
    minutesController.clear();
    descriptionController.clear(); 
    prepTime = null;
    ingredients.clear();
    methodSteps.clear();
    image = null;
  }

}
