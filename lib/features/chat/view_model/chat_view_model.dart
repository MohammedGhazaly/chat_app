import 'package:chat_app/model/message.dart';
import 'package:chat_app/utils/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MessageViewModel extends ChangeNotifier {
  final String roomId;
  final TextEditingController messageFieldController = TextEditingController();
  bool isEmpty = true;

  MessageViewModel({required this.roomId});
  sendMessage() {
    Message message = Message(
      roomId: roomId,
      senderName: SharedPrefUtils.getData("userName").toString(),
      senderId: FirebaseAuth.instance.currentUser!.uid,
      content: messageFieldController.text,
      date: DateTime.now().microsecondsSinceEpoch,
    );
    print(message.content);
    print(message.date);
    print(message.id);
    print(message.roomId);
    print(message.senderId);
    print(message.senderName);
  }

  void onChangedFunction(String messageContent) {
    if (messageContent.isNotEmpty) {
      isEmpty = false;
    } else {
      isEmpty = true;
    }
    notifyListeners();
  }
}
