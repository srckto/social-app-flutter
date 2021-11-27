import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/edit_profile_controller.dart';
import 'package:social_app/controllers/user_controller.dart';
import 'package:social_app/styles/Iconly-Broken_icons.dart';
import 'package:social_app/views/widgets/defult_button.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  TextEditingController _nameController = TextEditingController(text: UserController.model!.name);
  TextEditingController _bioController = TextEditingController(text: UserController.model!.bio);
  TextEditingController _phoneController = TextEditingController(text: UserController.model!.phone);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profile"),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Iconly_Broken.Arrow___Left_2),
        ),
        actions: [
          GetBuilder<EditProfileController>(
            init: EditProfileController(),
            builder: (controller) {
              return DefultButton(
                label: "UPDATE",
                elevation: 0.0,
                primaryColor: Colors.transparent,
                onPressed: () {
                  controller.updateUser(
                    name: _nameController.text,
                    bio: _bioController.text,
                    phone: _phoneController.text,
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<EditProfileController>(
                init: EditProfileController(),
                builder: (controller) {
                  return controller.isUpdateButtonPress
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: LinearProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : Container();
                },
              ),
              Container(
                height: 255,
                child: GetBuilder<EditProfileController>(
                  init: EditProfileController(),
                  builder: (controller) {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Stack(
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                ),
                                child: Image(
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  image: controller.coverImage == null
                                      ? NetworkImage(UserController.model!.cover!)
                                      : FileImage(controller.coverImage!) as ImageProvider,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 15,
                              top: 15,
                              child: CircleAvatar(
                                radius: 22,
                                child: IconButton(
                                  onPressed: () async {
                                    await controller.getCoverImage();
                                  },
                                  icon: Icon(Iconly_Broken.Camera),
                                  iconSize: 28,
                                ),
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 55,
                                backgroundImage: controller.profileImage == null
                                    ? NetworkImage(UserController.model!.image!)
                                    : FileImage(controller.profileImage!) as ImageProvider,
                              ),
                              CircleAvatar(
                                radius: 18,
                                child: IconButton(
                                  onPressed: () async {
                                    await controller.getProfileImage();
                                  },
                                  icon: Icon(Iconly_Broken.Camera),
                                  iconSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Icon(Iconly_Broken.User),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("Name"),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                controller: _nameController,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please enter your name";
                  } else
                    return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Icon(Iconly_Broken.Paper),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("Bio"),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                controller: _bioController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please enter your new bio";
                  } else
                    return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Icon(Iconly_Broken.Call),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("Phone"),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                controller: _phoneController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please enter your new phoneNumber";
                  } else
                    return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
