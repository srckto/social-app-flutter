import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/user_controller.dart';
import 'package:social_app/views/screens/social_layout.dart';

class LoginController extends GetxController {

  // To change between Login Button and CircularProgressIndicator
  bool isLoginButtonPress = false;

  // To show or hide a password
  bool visibilityOfPassword = true;

  // Function to change the value of a variable visibilityOfPassword
  void changeVisibility() {
    visibilityOfPassword = !visibilityOfPassword;
    update();
  }

  Future login({required String email, required String password}) async {
    try {
      // Change LoginButton to CircularProgressIndicator
      isLoginButtonPress = true;
      update();

      // SignIn user
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get user data
      await UserController.getUserData();

      // Change CircularProgressIndicator to default button
      isLoginButtonPress = false;
      update();

      // Navigate to homeScreen for app
      Get.off(() => SocialLayout());
    } on FirebaseAuthException catch (e) {
      // Change CircularProgressIndicator to default button
      isLoginButtonPress = false;
      update();

      // then, show an error in the screen
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
