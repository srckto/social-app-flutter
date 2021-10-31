import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/message_contoller.dart';
import 'package:social_app/controllers/user_controller.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/styles/Iconly-Broken_icons.dart';
import 'package:social_app/views/widgets/image_profile.dart';

// ignore: must_be_immutable
class ChatDetailsScreen extends StatelessWidget {
  final UserModel userModel;
  ChatDetailsScreen({required this.userModel});

  TextEditingController _textcontroller = TextEditingController();

  MessageController _messageController = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    _messageController.getMessages(receiveId: userModel.uId!);

    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (_messageController.messages.isEmpty) {
                  return Center(
                    child: Text(
                      "Not Fount Any message",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 20,
                          ),
                    ),
                  );
                } else
                  return ListView.separated(
                    reverse: true,
                    itemCount: _messageController.messages.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 10);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      if (_messageController.messages[index].senderId == UserController.model!.uId)
                        return _buildMyMessage(
                          context: context,
                          message: _messageController.messages[index].text,
                        );
                      else
                        return _buildOtherMessage(
                          message: _messageController.messages[index].text,
                        );
                    },
                  );
              }),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    SizedBox(width: 6),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Write your message here.....",
                          border: InputBorder.none,
                        ),
                        controller: _textcontroller,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _messageController.snedMessage(
                          receiveId: userModel.uId!,
                          text: _textcontroller.text,
                          dateTime: DateTime.now().toIso8601String(),
                        );

                        _textcontroller.clear();
                      },
                      child: Icon(
                        (Iconly_Broken.Send),
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildOtherMessage({required String message}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ImageProfile(image: userModel.image!, radius: 15),
        SizedBox(width: 6),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Text(message, style: TextStyle(fontSize: 17)),
        ),
      ],
    );
  }

  Row _buildMyMessage({required BuildContext context, required String message}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Text(
            message,
            style: TextStyle(fontSize: 17),
          ),
        ),
        SizedBox(width: 6),
        ImageProfile(image: UserController.model!.image!, radius: 15),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      titleSpacing: 0.0,
      title: Row(
        children: [
          ImageProfile(image: userModel.image!, radius: 18),
          SizedBox(width: 15),
          Text(userModel.name!),
        ],
      ),
      centerTitle: false,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(Iconly_Broken.Arrow___Left_2),
      ),
    );
  }
}
