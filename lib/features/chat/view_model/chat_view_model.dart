import 'dart:async';

import 'package:chat_app/model/message.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:chat_app/utils/shared_pref.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MessageViewModel extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription streamSubscription;
  final String roomId;
  final TextEditingController messageFieldController = TextEditingController();
  bool isSending = false;
  bool isEmpty = true;
  bool hasInternet = false;

  MessageViewModel({required this.roomId});

  void checkRealtimeConnection() {
    streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      switch (event) {
        case ConnectivityResult.mobile:
          {
            hasInternet = true;
            notifyListeners();
          }
          break;
        case ConnectivityResult.wifi:
          {
            hasInternet = true;
            notifyListeners();
          }
          break;
        default:
          {
            hasInternet = false;
            notifyListeners();
          }
          break;
      }
    });
  }

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
    messageFieldController.clear();
    await FireStoreService.saveMessageToFireStore(message);
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
