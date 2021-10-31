class CommentModel {
  String? coment;
  String? uId;
  String? name;
  String? image;
  String? dateTime;

  CommentModel({
    required this.coment,
    required this.uId,
    required this.name,
    required this.image,
    required this.dateTime,
  });

  CommentModel.fromJson(Map<String, dynamic> jsonData) {
    coment = jsonData["coment"];
    uId = jsonData["uId"];
    name = jsonData["name"];
    image = jsonData["image"];
    dateTime = jsonData["dateTime"];
  }

  Map<String, dynamic> toMap() {
    return {
      "coment": coment,
      "uId": uId,
      "name": name,
      "image": image,
      "dateTime": dateTime,
    };
  }
}
