class ChatRoom {
  late String title;
  late String description;
  late String roomType;
  late String? roomId;
  late String? adminId;
  late int? membersCount;
  ChatRoom({
    required this.roomType,
    required this.title,
    required this.description,
    this.roomId,
    this.adminId,
    this.membersCount,
  });
  ChatRoom.fromJson(Map<String, dynamic> jsonData) {
    roomType = jsonData["room_type"];
    title = jsonData["title"];
    description = jsonData["description"];
    roomId = jsonData["room_id"];
    adminId = jsonData["admin_id"];
    membersCount = jsonData["members_count"];
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "room_type": roomType,
      "room_id": roomId,
      "admin_id": adminId,
      "members_count": membersCount
    };
  }
}
