import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/user_controller.dart';
import 'package:social_app/views/screens/social_layout.dart';

class LoginController extends GetxController {

  bool isLoading = false;

  bool visibilityOfPassword = true;

  void changeVisibility() {
    visibilityOfPassword = !visibilityOfPassword;
    update();
  }

  Future login({required String email, required String password}) async {
    try {
      isLoading = true;
      update();

      // SignIn user
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get user data
      await UserController.getUserData();

      // Change CircularProgressIndicator to default button
      isLoading = false;
      update();

      // Navigate to homeScreen for app
      Get.off(() => SocialLayout());
    } on FirebaseAuthException catch (e) {
      // Change CircularProgressIndicator to default button
      isLoading = false;
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
