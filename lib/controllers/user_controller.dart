import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/models/user_model.dart';

class UserController {
  static UserModel? model;

  static getUserData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      String uId = FirebaseAuth.instance.currentUser!.uid;
      return await FirebaseFirestore.instance.collection("users").doc(uId).get().then((value) {
        print(value.data());
        model = UserModel.fromJson(value.data()!);
        print(model!.email);
      }).catchError((error) {
        print(error.toString());
      });
    } else
      return;
  }

}
