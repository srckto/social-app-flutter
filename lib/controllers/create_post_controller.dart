import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:social_app/controllers/user_controller.dart';
import 'package:social_app/models/post_model.dart';

class CreatePostController extends GetxController {
  File? postImage;
  bool state = false;

  Future getPostImage() async {
    final XFile? pikcedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pikcedFile != null) {
      postImage = File(pikcedFile.path);
    }
    update();
  }

  String postImageUrl = "";

  Future uploadPostImage() async {
    if (postImage != null) {
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
          .putFile(postImage!)
          .then((value) async {
        postImageUrl = await value.ref.getDownloadURL();
      }).catchError((error) {
        print(error.toString());
      });
    }
  }

  void deleteImage() {
    postImage = null;
    update();
  }

  Future createNewPost({
    required String text,
  }) async {
    state = true;
    update();
    String dateTime = DateFormat.yMMMd().format(DateTime.now());
    await uploadPostImage();
    PostModel postModel = PostModel(
      name: UserController.model!.name,
      uId: UserController.model!.uId,
      image: UserController.model!.image,
      postImage: postImageUrl,
      dateTime: dateTime,
      text: text,
      sortedByDateTime: DateTime.now().toIso8601String(),
      likeCount: 0,
      likes: {},
    );
    await FirebaseFirestore.instance.collection("posts").add(postModel.toMap()).then((value) {
      value.update({
        "postId": value.id,
      });
    }).catchError((error) {
      state = false;
      update();
      print(error.toString());
    });
    state = false;
    update();
    print("Complete Create a new post");
  }
}
