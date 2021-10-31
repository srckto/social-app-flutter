import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/user_controller.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/styles/Iconly-Broken_icons.dart';
import 'package:social_app/views/screens/chat_details_screen.dart';
import 'package:social_app/views/widgets/defult_button.dart';
import 'package:social_app/views/widgets/image_profile.dart';

class LikeDetails extends StatelessWidget {
  final List<UserModel> userModel;

  const LikeDetails({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Likes"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Iconly_Broken.Arrow___Left_2),
        ),
      ),
      body: userModel.isEmpty
          ? Center(child: Text("Not Found Any like"))
          : ListView.builder(
              itemCount: userModel.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ImageProfile(image: userModel[index].image!, radius: 20),
                      SizedBox(width: 7),
                      Expanded(
                        child: Text(
                          userModel[index].name!,
                          style: Theme.of(context).textTheme.headline3!.copyWith(),
                        ),
                      ),
                      if (userModel[index].uId != UserController.model!.uId)
                        DefultButton(
                          label: "Send Message",
                          fontSize: 15,
                          elevation: 0.0,
                          horizontalPadding: 7,
                          verticalPadding: 0.0,
                          radius: 7,
                          onPressed: () =>
                              Get.to(() => ChatDetailsScreen(userModel: userModel[index])),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
