import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/styles/Iconly-Broken_icons.dart';
import 'package:social_app/views/widgets/image_profile.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserModel userModel;
  const UserDetailsScreen({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userModel.name!),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Iconly_Broken.Arrow___Left_2),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 255,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
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
                              image: NetworkImage(
                                userModel.cover!,
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: ImageProfile(image: userModel.image!, radius: 55),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    userModel.name!,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
              SizedBox(height: 15),
              Column(
                children: [
                  _buildItem(context: context, title: "Email", subtitle: userModel.email!),
                  _buildItem(context: context, title: "Username", subtitle: userModel.uId!),
                  _buildItem(context: context, title: "PhoneNumber", subtitle: userModel.phone!),
                  _buildItem(context: context, title: "Bio", subtitle: userModel.bio!),
                  // _buildItem(context: context),
                  // _buildItem(context: context),
                  // _buildItem(context: context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildItem({
    required BuildContext context,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: 16,
                ),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subtitle),
              Divider(thickness: 2),
            ],
          ),
        ),
      ],
    );
  }
}
