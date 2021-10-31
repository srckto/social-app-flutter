import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/user_controller.dart';
import 'package:social_app/models/message_model.dart';

class MessageController extends GetxController {
  RxList messages = <MessageModel>[].obs;

  snedMessage({
    required String receiveId,
    required String text,
    required String dateTime,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: UserController.model!.uId,
      receiveId: receiveId,
      dateTime: dateTime,
      text: text,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(UserController.model!.uId)
        .collection("chats")
        .doc(receiveId)
        .collection("messages")
        .add(messageModel.toMap())
        .then((value) {
      print("Complete Sender");
    }).catchError((error) {
      print(error.toString());
    });

    FirebaseFirestore.instance
        .collection("users")
        .doc(receiveId)
        .collection("chats")
        .doc(UserController.model!.uId)
        .collection("messages")
        .add(messageModel.toMap())
        .then((value) {
      print("Complete receive");
    }).catchError((error) {
      print(error.toString());
    });
  }

  getMessages({
    required String receiveId,
  }) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(UserController.model!.uId)
        .collection("chats")
        .doc(receiveId)
        .collection("messages")
        .orderBy("dateTime", descending: true)
        .snapshots()
        .listen((event) {
      messages.clear();
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
    });
  }
}
