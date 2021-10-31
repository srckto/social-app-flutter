import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/users_controller.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/views/screens/users_detail_screen.dart';
import 'package:social_app/views/widgets/image_profile.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({Key? key}) : super(key: key);

  final UsersController _usersController = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _usersController.getAllUsers(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
        return ListView.separated(
          itemCount: _usersController.users.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              thickness: 1.5,
              endIndent: 15,
              indent: 15,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return _buildUsersItem(context: context, userModel: _usersController.users[index]);
          },
        );
      },
    );
  }

  Widget _buildUsersItem({required BuildContext context, required UserModel userModel}) {
    return InkWell(
      onTap: () {
        Get.to(() => UserDetailsScreen(userModel: userModel));
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ImageProfile(image: userModel.image!, radius: 25),
            SizedBox(width: 10),
            Text(
              userModel.name!,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: 18,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
