import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/controllers/user_controller.dart';
import 'package:social_app/models/user_model.dart';

class EditProfileController extends GetxController {
  File? profileImage;
  bool state = false;

  Future getProfileImage() async {
    final XFile? pikcedFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50);
    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (pikcedFile != null) {
      profileImage = File(pikcedFile.path);
    }
    update();
  }

  File? coverImage;

  Future getCoverImage() async {
    final XFile? pikcedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (pikcedFile != null) {
      coverImage = File(pikcedFile.path);
    }
    update();
  }

  String profileImageUrl = "";

  Future uploadProfileImage() async {
    if (profileImage != null) {
      await firebase_storage.FirebaseStorage.instance.ref().child("users/${Uri.file(profileImage!.path).pathSegments.last}").putFile(profileImage!).then((value) async {
        profileImageUrl = await value.ref.getDownloadURL();
      }).catchError((error) {
        print(error.toString());
      });
    }
  }

  String coverImageUrl = "";

  Future uploadCoverImage() async {
    if (coverImage != null) {
      await firebase_storage.FirebaseStorage.instance.ref().child("users/${Uri.file(coverImage!.path).pathSegments.last}").putFile(coverImage!).then((value) async {
        coverImageUrl = await value.ref.getDownloadURL();
      }).catchError((error) {
        print(error.toString());
      });
    }
  }

  Future updateUser({
    String? bio,
    String? name,
    String? phone,
  }) async {
    state = true;
    update();

    await uploadProfileImage();
    print("uploadProfileImage");
    await uploadCoverImage();
    print("uploadCoverImage");
    UserModel userModel = UserModel(
      bio: bio,
      name: name,
      phone: phone,
      image: profileImageUrl.isNotEmpty ? profileImageUrl : UserController.model!.image,
      cover: coverImageUrl.isNotEmpty ? coverImageUrl : UserController.model!.cover,
      email: UserController.model!.email,
      uId: UserController.model!.uId,
      isEmailVerified: UserController.model!.isEmailVerified,
    );

    await FirebaseFirestore.instance.collection("users").doc(UserController.model!.uId).update(userModel.toMap()).then((value) async {
      await UserController.getUserData();
      state = false;
      Get.back();
    });
    print("Complete");
  }
}
