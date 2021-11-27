import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/user_controller.dart';
import 'package:social_app/views/screens/social_layout.dart';

class LoginController extends GetxController {
  bool isLoginButtonPress = false;
  bool visibilityOfPassword = true;
  void changeVisibility() {
    visibilityOfPassword = !visibilityOfPassword;
    update();
  }

  Future login({required String email, required String password}) async {
    try {
      isLoginButtonPress = true;
      update();

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await UserController.getUserData();
      isLoginButtonPress = false;
      update();

      // Navigate to homeScreen for app

      Get.off(() => SocialLayout());
    } on FirebaseAuthException catch (e) {
      isLoginButtonPress = false;
      update();

      // Show an error in the screen
      Get.snackbar(
        "Error",
        e.message.toString(),
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(15),
        snackPosition: SnackPosition.BOTTOM,
      );

      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
