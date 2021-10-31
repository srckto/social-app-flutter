class MessageModel {
  String? senderId;
  String? receiveId;
  String? dateTime;
  String? text;


  MessageModel({
    required this.senderId,
    required this.receiveId,
    required this.dateTime,
    required this.text,

  });

  MessageModel.fromJson(Map<String, dynamic> jsonData) {
    senderId = jsonData["senderId"];
    text = jsonData["text"];
    receiveId = jsonData["receiveId"];
    dateTime = jsonData["dateTime"];
  }

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "receiveId": receiveId,
      "dateTime": dateTime,
      "text": text,
    };
  }
}
