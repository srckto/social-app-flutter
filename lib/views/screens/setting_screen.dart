import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/user_controller.dart';
import 'package:social_app/styles/Iconly-Broken_icons.dart';
import 'package:social_app/views/screens/edit_profile_screen.dart';
import 'package:social_app/views/widgets/image_profile.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
                          UserController.model!.cover!,
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: ImageProfile(image: UserController.model!.image!, radius: 55),
                  ),
                ],
              ),
            ),
            Text(
              UserController.model!.name!,
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              UserController.model!.bio!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 16,
                  ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text(
                          "100",
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                fontSize: 16,
                              ),
                        ),
                        Text(
                          "Post",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 14,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text(
                          "50",
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                fontSize: 16,
                              ),
                        ),
                        Text(
                          "Photos",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 14,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text(
                          "7K",
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                fontSize: 16,
                              ),
                        ),
                        Text(
                          "Followers",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 14,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text(
                          "54",
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                fontSize: 16,
                              ),
                        ),
                        Text(
                          "Following",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 14,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(),
                    onPressed: () {},
                    child: Text(
                      "Add image",
                      style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 2),
                OutlinedButton(
                  onPressed: () async {
                    await Get.to(() => EditProfileScreen())!.then((value) {
                      setState(() {});
                    });
                  },
                  child: Icon(Iconly_Broken.Edit),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
