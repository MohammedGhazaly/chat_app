import 'package:chat_app/features/chat/view/widgets/chat_body.dart';
import 'package:chat_app/features/chat/view/widgets/custom_app_bar_actions.dart';
import 'package:chat_app/model/chat_room.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  static String routeName = "chat-view";
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    var roomArgs = ModalRoute.of(context)!.settings.arguments as ChatRoom;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            "assets/images/background@3x.png",
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text(
            roomArgs.title,
          ),
          actions: [
            CustomAppBarActions(roomId: roomArgs.roomId!),
          ],
        ),
        body: ChatBody(roomId: roomArgs.roomId!),
      ),
    );
  }
}
