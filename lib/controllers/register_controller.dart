import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/user_controller.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/views/screens/social_layout.dart';

class RegisterController extends GetxController {

  // To change between Register Button and CircularProgressIndicator
  bool isRegisterButtonPress = false;

  // To show or hide a password
  bool visibilityOfPassword = true;

  // Function to change the value of a variable visibilityOfPassword
  void changeVisibility() {
    visibilityOfPassword = !visibilityOfPassword;
    update();
  }

  Future register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {

      // Change LoginButton to CircularProgressIndicator
      isRegisterButtonPress = true;
      update();

      // Create a user account in firebaseAuth
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create Model to user
      UserModel model = UserModel(
        email: email,
        name: name,
        phone: phone,
        uId: userCredential.user!.uid,
        isEmailVerified: false,
        image:
            "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png",
        bio: "Write a bio",
        cover: "https://image.freepik.com/free-photo/friends-social-media_53876-90180.jpg",
      );

      // then, Create user in fireStore to save data online
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(model.toMap());


      // Get user data and save
      await UserController.getUserData();


      // Change CircularProgressIndicator to default button
      isRegisterButtonPress = false;
      update();

      // Navigate to a home screen of the app
      Get.off(() => SocialLayout());
    } on FirebaseAuthException catch (e) {

      // Change CircularProgressIndicator to default button
      isRegisterButtonPress = false;
      update();

      // Show an error in the screen to user
      Get.snackbar(
        "Error",
        e.message.toString(),
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(15),
        snackPosition: SnackPosition.BOTTOM,
      );

    } 
  }
}
