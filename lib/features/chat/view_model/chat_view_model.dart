import 'package:chat_app/model/message.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:chat_app/utils/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MessageViewModel extends ChangeNotifier {
  final String roomId;
  final TextEditingController messageFieldController = TextEditingController();
  bool isSending = false;
  bool isEmpty = true;

  MessageViewModel({required this.roomId});
  sendMessage() async {
    Message message = Message(
      roomId: roomId,
      senderName: SharedPrefUtils.getData("userName").toString(),
      senderId: FirebaseAuth.instance.currentUser!.uid,
      content: messageFieldController.text,
      date: DateTime.now().millisecondsSinceEpoch,
    );
    isSending = true;
    notifyListeners();
    await FireStoreService.saveMessageToFireStore(message);
    messageFieldController.clear();
    onChangedFunction(messageFieldController.text);
    isSending = false;
    notifyListeners();
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
