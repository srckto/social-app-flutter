import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/user_controller.dart';
import 'package:social_app/views/screens/social_layout.dart';

class LoginController extends GetxController {
  RxBool state = false.obs;
  RxBool visibility = true.obs;
  void changeVisibility() {
    visibility.value = !visibility.value;
  }

  Future login({required String email, required String password}) async {
    try {
      state.value = true;
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await UserController.getUserData();
      state.value = false;

      // Navigate to homeScreen for app

      Get.off(() => SocialLayout());
    } on FirebaseAuthException catch (e) {
      state.value = false;

      // Show error to user if found

      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(15),
        snackPosition: SnackPosition.BOTTOM,
      );

      // print in consel

      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
