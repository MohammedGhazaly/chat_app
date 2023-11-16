import 'package:chat_app/data/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  static Future<void> saveUserToFireStore(MyUser user) async {
    await FirebaseFirestore.instance.collection("users").doc(user.id).set({
      "id": user.id,
      "email": user.email,
      "user_name": user.userName,
    });
  }

  static Future<MyUser> getFireStoreUser(String id) async {
    final userDocument =
        await FirebaseFirestore.instance.collection("users").doc(id).get();
    return MyUser(
      id: id,
      email: userDocument["email"],
      userName: userDocument["user_name"],
    );
  }
}
