import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/user_controller.dart';
import 'package:social_app/models/user_model.dart';

class ChatController extends GetxController {
  List<UserModel> users = [];

  Future getAllUsers() async {
    users = [];
    return await FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element) {
        if (element.id != UserController.model!.uId) {
          users.add(UserModel.fromJson(element.data()));
          update();
        }
      });
    }).catchError((error) {
      print(error.toString());
    });
  }
}
