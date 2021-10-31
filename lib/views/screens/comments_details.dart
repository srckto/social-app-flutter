import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/styles/Iconly-Broken_icons.dart';
import 'package:social_app/views/widgets/image_profile.dart';

class CommentDetailsScreen extends StatelessWidget {
  final List<CommentModel> comments;
  final PostModel postModel;
  CommentDetailsScreen({required this.comments, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Iconly_Broken.Arrow___Left_2),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              ...comments
                  .map(
                    (element) => Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImageProfile(image: element.image!, radius: 20),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "${element.name!} ",
                                          style: Theme.of(context).textTheme.headline3!.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                        ),
                                        TextSpan(
                                          text: element.coment!,
                                          style: Theme.of(context).textTheme.headline3!.copyWith(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    element.dateTime!,
                                    style: Theme.of(context).textTheme.caption!.copyWith(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
