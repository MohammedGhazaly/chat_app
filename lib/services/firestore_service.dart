import 'package:chat_app/model/chat_room.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireStoreService {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance.collection("users").withConverter<MyUser>(
        fromFirestore: (snapshot, _) {
      return MyUser.fromJson(snapshot.data()!);
    }, toFirestore: (user, _) {
      return user.toJson();
    });
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

  // static CollectionReference<ChatRoom> getRoomsCollectionForUser(
  //     String userId) {
  //   return getUserCollection()
  //       .doc(userId)
  //       .collection("rooms")
  //       .withConverter<ChatRoom>(
  //     fromFirestore: (snapshot, _) {
  //       return ChatRoom.fromJson(snapshot.data()!);
  //     },
  //     toFirestore: (room, _) {
  //       return room.toJson();
  //     },
  //   );
  // }

  static Future<void> saveUserToFireStore(MyUser user) async {
    await getUserCollection().doc(user.id).set(user);

    //     .doc(user.id)
    //     .set({
    //   "id": user.id,
    //   "email": user.email,
    //   "user_name": user.userName,
    // });
  }

  static Future<MyUser> getFireStoreUser(String id) async {
    var userSnapShot = await getUserCollection().doc(id).get();
    return userSnapShot.data()!;
  }

  // static Future<List<String>> getUserIdsExceptLoggedUser() async {
  //   List<String> ids = [];
  //   QuerySnapshot<MyUser> usersSnapshot = await getUserCollection().get();
  //   for (var doc in usersSnapshot.docs) {
  //     if (doc.data().id != FirebaseAuth.instance.currentUser!.uid) {
  //       ids.add(doc.id);
  //     }
  //   }
  //   return ids;
  // }

  // Add

  // Rooms Collection

  static Future<void> createRoomInFireStore(ChatRoom room) async {
    var doc = getRoomsCollection().doc();
    room.roomId = doc.id;
    room.adminId = FirebaseAuth.instance.currentUser!.uid;
    debugPrint(room.members[0]);
    await doc.set(room);
  }

  // static Future<void> addRoomToUser(String userId, ChatRoom chatRoom) async {
  //   await getRoomsCollectionForUser(userId).doc(chatRoom.roomId).set(chatRoom);
  // }

  static Stream<QuerySnapshot<ChatRoom>> getAllRooms() async* {
    // var usersId = await FireStoreService.getUserIdsExceptLoggedUser();
    // print(usersId);

    yield* getRoomsCollection().where("members").snapshots();
  }

  static Stream<QuerySnapshot<ChatRoom>> getLoggedUsersRoom() async* {
    yield* getRoomsCollection()
        .where("members", arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  static Future<bool> checkIfUserInRoom(String roomId) async {
    var chatRoom = await getRoomsCollection().doc(roomId).get();
    if (chatRoom
        .data()!
        .members
        .contains(FirebaseAuth.instance.currentUser!.uid)) {
      return true;
    }
    return false;
  }

  static Future<void> incrementMembers(String roomId) async {
    // return getRoomsCollection().snapshots();
    var doc = getRoomsCollection().doc(roomId);
    var chatRoom = await doc.get();
    var newMembersCount = chatRoom.data()!.membersCount + 1;
    doc.update({
      "members_count": newMembersCount,
    });
  }

  static Future<void> decrementMembers(String roomId) async {
    var doc = getRoomsCollection().doc(roomId);
    var chatRoom = await doc.get();
    var newMembersCount = chatRoom.data()!.membersCount - 1;
    doc.update({
      "members_count": newMembersCount,
    });
  }

  static Future<void> addUserToRoom(
      {required String roomId, required String userId}) async {
    var doc = getRoomsCollection().doc(roomId);
    var chatRoom = await doc.get();
    var usersList = chatRoom.data()!.members;
    usersList.add(userId);
    doc.update({
      "members": usersList,
    });
  }

  // Remove user from room
  static removeUserFromRoom(String roomId) async {
    final roomSnapShot = await getRoomsCollection().doc(roomId).get();
    final List<String> newMembers = roomSnapShot.data()!.members;
    for (var member in roomSnapShot.data()!.members) {
      if (member == FirebaseAuth.instance.currentUser!.uid) {
        newMembers.remove(member);
      }
    }
    await decrementMembers(roomId);
    await getRoomsCollection().doc(roomId).update({"members": newMembers});
  }

  // Message Methods
  static CollectionReference<Map<String, dynamic>> getMessageCollection(
      String roomId) {
    return FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .collection("messages");
    //     .withConverter<Message>(
    //   fromFirestore: (snapShot, _) {
    //     return Message.fromJson(snapShot.data()!);
    //   },
    //   toFirestore: (fireStoreMessage, _) {
    //     return fireStoreMessage.toJson();
    //   },
    // );
  }

  static Future<void> saveMessageToFireStore(Message message) async {
    DocumentReference<Map<String, dynamic>> messageRef =
        getMessageCollection(message.roomId!).doc();
    message.id = messageRef.id;
    await messageRef.set({
      "content": message.content,
      "date": FieldValue.serverTimestamp(),
      "id": message.id,
      "room_id": message.roomId,
      "sender_id": message.senderId,
      "sender_name": message.senderName
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      String roomId) async* {
    yield* getMessageCollection(roomId)
        .orderBy("date", descending: false)
        .snapshots();
  }
}
