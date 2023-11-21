class Message {
  String? id;
  String? roomId;
  String? senderName;
  String? senderId;
  String? content;
  int? date;

  Message({
    this.id = "",
    required this.roomId,
    required this.senderName,
    required this.senderId,
    required this.content,
    required this.date,
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    roomId = json["room_id"];
    senderName = json["sender_name"];
    senderId = json["sender_id"];
    content = json["content"];
    date = json["date_sent"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "room_id": roomId,
      "sender_name": senderName,
      "sender_id": senderId,
      "content": content,
      "date_sent": date,
    };
  }
}
