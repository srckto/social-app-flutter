class PostModel {
  String? name;
  String? uId;
  String? image;
  String? text;
  String? dateTime;
  String? postImage;
  String? postId;
  String? sortedByDateTime; // to sort posts
  Map? likes;
  int? likeCount;

  PostModel({
    required this.name,
    required this.postImage,
    required this.uId,
    required this.image,
    required this.dateTime,
    required this.text,
    required this.sortedByDateTime,
    required this.likeCount,
    required this.likes,
    this.postId,
  });

  PostModel.fromJson(Map<String, dynamic> jsonData) {
    name = jsonData["name"];
    postImage = jsonData["postImage"];
    uId = jsonData["uId"];
    image = jsonData["image"];
    text = jsonData["text"];
    dateTime = jsonData["dateTime"];
    postId = jsonData["postId"];
    sortedByDateTime = jsonData["sortedByDateTime"];
    likes = jsonData["likes"];
    likeCount = jsonData["likeCount"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "postImage": postImage,
      "uId": uId,
      "image": image,
      "text": text,
      "dateTime": dateTime,
      "sortedByDateTime": sortedByDateTime,
      "postId": postId, // Don't need this line ,add this from function
      "likes": likes,
      "likeCount": likeCount,
    };
  }
}
