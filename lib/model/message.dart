import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? id;
  String? roomId;
  String? senderName;
  String? senderId;
  String? content;
  DateTime? date = DateTime.now();

  Message({
    this.id = "",
    required this.roomId,
    required this.senderName,
    required this.senderId,
    required this.content,
    this.date,
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    roomId = json["room_id"];
    senderName = json["sender_name"];
    senderId = json["sender_id"];
    content = json["content"];
    // date = DateTime.parse(json["date"] as String).toLocal();
    // date = DateTime.now();
    if (json["date"] == null) {
      date = DateTime.now();
    } else {
      date = (json["date"] as Timestamp).toDate().toLocal();
    }
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     "id": id,
  //     "room_id": roomId,
  //     "sender_name": senderName,
  //     "sender_id": senderId,
  //     "content": content,
  //     "date": date,
  //   };
  // }
}
