class MessageModel {
  String userName;
  String message;

  MessageModel({required this.userName, required this.message});

  factory MessageModel.fromJSON(Map<String, dynamic> data) {
    return MessageModel(userName: data["userName"], message: data["message"]);
  }

  Map<String, dynamic> toJSON() {
    return {"userName": userName, "message": message};
  }
}
