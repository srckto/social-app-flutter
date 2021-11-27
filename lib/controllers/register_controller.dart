import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/user_controller.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/views/screens/social_layout.dart';

class RegisterController extends GetxController {
  bool isRegisterButtonPress = false;
  bool visibilityOfPassword = true;
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
      // Create user in firebaseAuth

      isRegisterButtonPress = true;
      update();

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Now Create user in fireStore

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
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(model.toMap());

      await UserController.getUserData();

      isRegisterButtonPress = false;
      update();
      Get.off(() => SocialLayout());
    } on FirebaseAuthException catch (e) {
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

      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
