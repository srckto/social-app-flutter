import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/create_post_controller.dart';
import 'package:social_app/controllers/user_controller.dart';
import 'package:social_app/styles/Iconly-Broken_icons.dart';
import 'package:social_app/views/widgets/defult_button.dart';
import 'package:social_app/views/widgets/image_profile.dart';

// ignore: must_be_immutable
class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({Key? key}) : super(key: key);

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create post"),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Iconly_Broken.Arrow___Left_2),
        ),
        actions: [
          GetBuilder<CreatePostController>(
            init: CreatePostController(),
            builder: (controller) {
              return DefultButton(
                label: "Post",
                labelColor: Colors.black,
                verticalPadding: 0.0,
                onPressed: () {
                  controller.createNewPost(
                    text: _textEditingController.text,
                  );
                },
                primaryColor: Colors.transparent,
                elevation: 0.0,
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GetBuilder<CreatePostController>(
              init: CreatePostController(),
              builder: (controller) {
                return controller.state
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: LinearProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : Container();
              },
            ),
            Row(
              children: [
                ImageProfile(image: UserController.model!.image!, radius: 25),
                SizedBox(width: 10),
                Text(
                  UserController.model!.name!,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 18,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "What is on your mind...",
                        border: InputBorder.none,
                      ),
                      maxLines: 3,
                      controller: _textEditingController,
                      validator: (value) {
                        if (value!.trim().isEmpty)
                          return "you must not be empty";
                        else
                          return null;
                      },
                    ),
                    GetBuilder<CreatePostController>(
                      init: CreatePostController(),
                      builder: (controller) {
                        return controller.postImage != null
                            ? Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 8,
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Stack(
                                  children: [
                                    Image(
                                      image: FileImage(controller.postImage!),
                                      fit: BoxFit.cover,
                                      height: 200,
                                      width: double.infinity,
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 12,
                                      child: CircleAvatar(
                                        child: IconButton(
                                          onPressed: () {
                                            controller.deleteImage();
                                          },
                                          icon: Icon(Iconly_Broken.Close_Square),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container();
                      },
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                GetBuilder<CreatePostController>(
                  init: CreatePostController(),
                  builder: (controller) {
                    return Expanded(
                      child: TextButton(
                        onPressed: () {
                          controller.getPostImage();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconly_Broken.Image),
                            SizedBox(width: 5),
                            Text("Add Photo"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: Text("# tags"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
