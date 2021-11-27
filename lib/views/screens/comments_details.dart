import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/home_controller.dart';
import 'package:social_app/controllers/user_controller.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/styles/Iconly-Broken_icons.dart';
import 'package:social_app/views/widgets/image_profile.dart';

// ignore: must_be_immutable
class CommentDetailsScreen extends StatelessWidget {
  // List<CommentModel> comments;
  final PostModel postModel;
  CommentDetailsScreen({required this.postModel});

  final HomeController _homeController = Get.put(HomeController());

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _homeController.showComments(postId: postModel.postId!);

    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Iconly_Broken.Arrow___Left_2),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageProfile(image: postModel.image!, radius: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${postModel.name!} ",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                      ),
                      Text(
                        postModel.text!,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(thickness: 2),
            Expanded(
              child: GetBuilder<HomeController>(
                builder: (_) => ListView.builder(
                  // shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: _homeController.comments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImageProfile(image: _homeController.comments[index].image!, radius: 20),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "${_homeController.comments[index].name!} ",
                                          style: Theme.of(context).textTheme.headline3!.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                        ),
                                        TextSpan(
                                          text: _homeController.comments[index].coment!,
                                          style: Theme.of(context).textTheme.headline3!.copyWith(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    _homeController.comments[index].dateTime!,
                                    style: Theme.of(context).textTheme.caption!.copyWith(),
                                  ),
                                ],
                              ),
                            ),
                            if (UserController.model!.uId == _homeController.comments[index].uId)
                              TextButton(
                                onPressed: () {
                                  _homeController.deleteComment(
                                    postId: postModel.postId!,
                                    commentModel: _homeController.comments[index],
                                  );
                                },
                                child: Text("delete", style: TextStyle(color: Colors.red)),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

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
                          hintText: "Write your commet here.....",
                          border: InputBorder.none,
                        ),
                        controller: _textController,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await _homeController.createComment(
                          postId: postModel.postId!,
                          commentText: _textController.text,
                        );
                        _textController.clear();
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

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     ImageProfile(image: UserController.model!.image!, radius: 18),
            //     SizedBox(width: 6),
            //     Expanded(
            //       child: TextFormField(
            //         decoration: InputDecoration(
            //           hintText: "Write a comment.....",
            //           border: InputBorder.none,
            //         ),
            //         controller: _textController,
            //       ),
            //     ),
            //     InkWell(
            //       onTap: () {
            //         _homeController.commentPost(
            //           postId: postModel.postId!,
            //           comment: _textController.text,
            //         );
            //         _textController.clear();
            //       },
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            //         child: Row(
            //           children: [
            //             Icon(
            //               (Iconly_Broken.Send),
            //               color: Colors.amber,
            //             ),
            //             SizedBox(width: 5),
            //             Text("send"),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            // ...comments
            //     .map(
            //       (element) => Container(
            //         padding: EdgeInsets.symmetric(vertical: 10),
            //         child: Container(
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               ImageProfile(image: element.image!, radius: 20),
            //               SizedBox(width: 10),
            //               Expanded(
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text.rich(
            //                       TextSpan(
            //                         children: [
            //                           TextSpan(
            //                             text: "${element.name!} ",
            //                             style: Theme.of(context).textTheme.headline3!.copyWith(
            //                                   fontWeight: FontWeight.w600,
            //                                   fontSize: 16,
            //                                 ),
            //                           ),
            //                           TextSpan(
            //                             text: element.coment!,
            //                             style: Theme.of(context).textTheme.headline3!.copyWith(
            //                                   fontWeight: FontWeight.normal,
            //                                   fontSize: 16,
            //                                 ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                     Text(
            //                       element.dateTime!,
            //                       style: Theme.of(context).textTheme.caption!.copyWith(),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               if (UserController.model!.uId == element.uId)
            //                 IconButton(
            //                   onPressed: () {
            //                     _homeController.deleteComment(
            //                       postId: postModel.postId!,
            //                       commentModel: element,
            //                     );
            //                   },
            //                   icon: Icon(Icons.more_horiz),
            //                 ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     )
            //     .toList(),
          ],
        ),
      ),
    );
  }
}
