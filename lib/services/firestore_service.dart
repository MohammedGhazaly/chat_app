import 'package:chat_app/model/room_category.dart';
import 'package:chat_app/model/chat_room.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

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

  static CollectionReference<ChatRoom> getRoomsCollection() {
    return FirebaseFirestore.instance
        .collection("rooms")
        .withConverter<ChatRoom>(fromFirestore: (snapshot, _) {
      return ChatRoom.fromJson(snapshot.data()!);
    }, toFirestore: (room, _) {
      return room.toJson();
    });
  }

  static Future<void> createRoomInFireStore(ChatRoom room) async {
    var doc = getRoomsCollection().doc();
    room.roomId = doc.id;
    room.adminId = FirebaseAuth.instance.currentUser!.uid;
    await doc.set(room);
  }
}
