import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_app/controllers/user_controller.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';

class HomeController extends GetxController {
  List<PostModel> posts = [];

  List<CommentModel> comments = [];

  final _fireStore = FirebaseFirestore.instance;

  getPosts() async {
    _fireStore
        .collection("posts")
        .orderBy("sortedByDateTime", descending: true)
        .snapshots()
        .listen((event) {
      posts.clear();
      event.docs.forEach((element) {
        posts.add(PostModel.fromJson(element.data()));
      });
      update();
    });
  }

  Future likePost({required PostModel postModel}) async {
    if (postModel.likes!.containsKey(UserController.model!.uId)) {
      bool _isLiked = postModel.likes![UserController.model!.uId];
      if (_isLiked) {
        await _fireStore
            .collection("posts")
            .doc(postModel.postId)
            .update({
              "likes.${UserController.model!.uId!}": false,
              "likeCount": (postModel.likeCount! - 1),
            })
            .then((value) {})
            .catchError((error) {
              print(error.toString());
            });
        update();
      } else {
        await _fireStore
            .collection("posts")
            .doc(postModel.postId)
            .update({
              "likes.${UserController.model!.uId!}": true,
              "likeCount": (postModel.likeCount! + 1),
            })
            .then((value) {})
            .catchError((error) {
              print(error.toString());
            });
        update();
      }
    } else {
      await _fireStore
          .collection("posts")
          .doc(postModel.postId)
          .update({
            "likes.${UserController.model!.uId!}": true,
            "likeCount": (postModel.likeCount! + 1),
          })
          .then((value) {})
          .catchError((error) {
            print(error.toString());
          });
      update();
    }
  }

  Future commentPost({required String postId, required String comment}) async {
    String formattedDate = DateFormat('d MMMM - kk:mm:ss').format(DateTime.now());
    CommentModel commentModel = CommentModel(
      coment: comment,
      dateTime: formattedDate,
      uId: UserController.model!.uId,
      name: UserController.model!.name,
      image: UserController.model!.image,
    );

    await _fireStore
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .add(commentModel.toMap())
        .then((value) {
      value.update({
        "commentId": value.id,
      });
      
      update();
    }).catchError((error) {
      print(error.toString());
    });

    update();
  }

  Future showComments({required String postId}) async {
    comments = [];

    return await _fireStore
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .orderBy("dateTime", descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        comments.add(CommentModel.fromJson(element.data()));
      });
      print(comments);
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future deleteComment({
    required String postId,
    required CommentModel commentModel,
  }) async {
    //Use it when an error occurs.
    CommentModel _currentModel = commentModel;

    comments.remove(commentModel);
    update();

    await _fireStore
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .doc(commentModel.commentId)
        .delete()
        .catchError((error) {
      comments.add(_currentModel);
      update();
      print(error);
    });
  }

  Future<List<UserModel>> showLikes({required PostModel postModel}) async {
    List<String> _uIdOfUsers = [];
    List<UserModel> _users = [];
    // get uid of the users who give a like.
    postModel.likes!.forEach((key, value) {
      if (value == true) {
        _uIdOfUsers.add(key);
      }
    });

    // get all users who give likes for a post
    await _fireStore.collection("users").get().then((value) {
      _uIdOfUsers.forEach((elementOne) {
        value.docs.forEach((elementTwo) {
          if (elementTwo.data()["uId"] == elementOne) {
            _users.add(UserModel.fromJson(elementTwo.data()));
          }
        });
      });
    });
    return _users;
  }
}
