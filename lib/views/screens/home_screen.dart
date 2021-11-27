import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/home_controller.dart';
import 'package:social_app/controllers/user_controller.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/styles/Iconly-Broken_icons.dart';
import 'package:social_app/views/screens/comments_details.dart';
import 'package:social_app/views/screens/likes_details.dart';
import 'package:social_app/views/widgets/image_profile.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeController _homeController = Get.put(HomeController());

  List<TextEditingController> _controllers = [];

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    _homeController.getPosts();
    return RefreshIndicator(
      onRefresh: () => _homeController.getPosts(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 0),
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 8,
              margin: EdgeInsets.all(10),
              child: Image(
                image: NetworkImage(
                  "https://image.freepik.com/free-photo/friends-social-media_53876-90180.jpg",
                ),
                fit: BoxFit.cover,
                height: 200,
                width: _size.width,
              ),
            ),
            GetBuilder<HomeController>(
              init: HomeController(),
              builder: (controller) {
                return Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildPostItem(context, _size, controller.posts[index], index);
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Card _buildPostItem(BuildContext context, Size _size, PostModel postModel, int index) {
    _controllers.add(new TextEditingController());
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 8,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ImageProfile(image: postModel.image!, radius: 25),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            postModel.name!,
                            style: Theme.of(context).textTheme.headline3!.copyWith(
                                  fontSize: 18,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.check_circle_outline,
                            color: Theme.of(context).primaryColor,
                            size: 20,
                          ),
                        ],
                      ),
                      Text(
                        postModel.dateTime!,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz_rounded),
                ),
              ],
            ),
            Divider(thickness: 1),
            Text(
              postModel.text!,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
            ),
            SizedBox(height: 10),
            if (postModel.postImage!.isNotEmpty)
              Image(
                width: _size.width,
                height: 200,
                fit: BoxFit.cover,
                image: NetworkImage(
                  postModel.postImage!,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    List<UserModel> _users = await _homeController.showLikes(postModel: postModel);
                    Get.to(() => LikeDetails(userModel: _users));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Row(
                      children: [
                        Icon(
                          Iconly_Broken.Heart,
                          color: Colors.red,
                          size: 22,
                        ),
                        SizedBox(width: 5),
                        Text("${postModel.likeCount}"),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    Get.to(
                      () => CommentDetailsScreen(
                        postModel: postModel,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Row(
                      children: [
                        Icon(
                          Iconly_Broken.Chat,
                          color: Colors.amber,
                          size: 22,
                        ),
                        SizedBox(width: 5),
                        Text("Show comments"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ImageProfile(image: UserController.model!.image!, radius: 18),
                SizedBox(width: 6),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Write a comment.....",
                      border: InputBorder.none,
                    ),
                    controller: _controllers[index],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _homeController.likePost(
                      postModel: postModel,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Row(
                      children: [
                        Icon(
                          Iconly_Broken.Heart,
                          color: Colors.red,
                        ),
                        SizedBox(width: 5),
                        Text("Like"),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _homeController.createComment(
                      postId: postModel.postId!,
                      commentText: _controllers[index].text,
                    );
                    _controllers[index].clear();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Row(
                      children: [
                        Icon(
                          (Iconly_Broken.Send),
                          color: Colors.amber,
                        ),
                        SizedBox(width: 5),
                        Text("send"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


//   if (UserController.model!.isEmailVerified! == false)
            //     Container(
            //       width: _size.width * 0.9,
            //       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            //       decoration: BoxDecoration(
            //         color: Colors.grey[400],
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Icon(
            //             Icons.info_outline_rounded,
            //           ),
            //           SizedBox(width: 15),
            //           Text(
            //             "Please verify your email",
            //             style: Theme.of(context).textTheme.headline3,
            //           ),
            //           DefultIcon(
            //             label: "verify",
            //             onPressed: () {},
            //             elevation: 0.0,
            //             primaryColor: Colors.transparent,
            //             horizontalPadding: 10,
            //             labelColor: Theme.of(context).primaryColor,
            //           ),
            //         ],
            //       ),
            //     ),
            