class MyUser {
  late final String id;
  late final String email;
  late final String userName;

  MyUser({required this.id, required this.email, required this.userName});
  MyUser.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData["id"];
    email = jsonData["email"];
    userName = jsonData["user_name"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "user_name": userName,
    };
  }
}
