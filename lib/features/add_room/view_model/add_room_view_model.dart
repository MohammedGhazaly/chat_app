import 'package:chat_app/features/add_room/navigator/add_room_navigator.dart';
import 'package:chat_app/model/chat_room.dart';
import 'package:chat_app/model/room_category.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddRoomViewModel extends ChangeNotifier {
  late AddRoomNavigator navigator;
  List<RoomCategory> chatCategories = RoomCategory.categories;
  final formKey = GlobalKey<FormState>();
  RoomCategory selectedCategory = RoomCategory.categories[0];
  final TextEditingController roomNameController = TextEditingController();
  final TextEditingController roomDescController = TextEditingController();
  bool isCreating = false;

  String? roomNameValidatorFunc(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name can't be empty";
    } else if (value.length < 3) {
      return "Name should be at least  chars";
    }
    return null;
  }

  String? roomDescValidatorFunc(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Description can't be empty";
    } else if (value.length < 3) {
      return "Description should be at least 3 chars";
    }
    return null;
  }

  void Function(RoomCategory?)? onCategoryChanged(value) {
    selectedCategory = value ?? selectedCategory;
    notifyListeners();
    return null;
  }

  Future<void> createRoom() async {
    if (formKey.currentState!.validate()) {
      ChatRoom chatRoom = ChatRoom(
          roomType: selectedCategory.name,
          title: roomNameController.text,
          description: roomDescController.text,
          adminId: FirebaseAuth.instance.currentUser!.uid,
          members: [FirebaseAuth.instance.currentUser!.uid],
          membersCount: 1);
      try {
        isCreating = true;
        notifyListeners();
        await FireStoreService.createRoomInFireStore(chatRoom);
        navigator.backToHome();
      } catch (e) {}
      isCreating = false;
      notifyListeners();
    }
  }
}
