class MessageModel {
  String id;
  String userName;
  String message;

  MessageModel(
      {required this.id, required this.userName, required this.message});

  factory MessageModel.fromJSON(Map<String, dynamic> data) {
    return MessageModel(
        id: data["id"], userName: data["userName"], message: data["message"]);
  }

  Map<String, dynamic> toJSON() {
    return {"id": id, "userName": userName, "message": message};
  }
}
