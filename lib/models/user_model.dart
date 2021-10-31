class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.image,
    required this.cover,
    required this.isEmailVerified,
    required this.bio,
  });

  UserModel.fromJson(Map<String, dynamic> jsonData) {
    name = jsonData["name"];
    email = jsonData["email"];
    phone = jsonData["phone"];
    uId = jsonData["uId"];
    isEmailVerified = jsonData["isEmailVerified"];
    image = jsonData["image"];
    bio = jsonData["bio"];
    cover = jsonData["cover"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name" : name,
      "email" : email,
      "phone" : phone,
      "uId" : uId,
      "isEmailVerified" : isEmailVerified,
      "image" : image,
      "bio" : bio,
      "cover" : cover,
    };
  }
}
