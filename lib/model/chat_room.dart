class ChatRoom {
  late String title;
  late String description;
  late String roomType;
  late String adminId;
  late int membersCount;
  late List<String> members;
  late String? roomId;
  ChatRoom({
    required this.roomType,
    required this.title,
    required this.description,
    required this.adminId,
    required this.membersCount,
    required this.members,
    this.roomId,
  });
  ChatRoom.fromJson(Map<String, dynamic> jsonData) {
    roomType = jsonData["room_type"];
    title = jsonData["title"];
    description = jsonData["description"];
    roomId = jsonData["room_id"];
    adminId = jsonData["admin_id"];
    membersCount = jsonData["members_count"];
    members = jsonData['members'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "room_type": roomType,
      "room_id": roomId,
      "admin_id": adminId,
      "members_count": membersCount,
      "members": members
    };
  }
}
