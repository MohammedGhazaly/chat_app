import 'package:chat_app/features/chat/view/widgets/messages_list.dart';
import 'package:chat_app/features/chat/view_model/chat_view_model.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:chat_app/utils/my_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChatBody extends StatefulWidget {
  final String roomId;
  const ChatBody({super.key, required this.roomId});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  late MessageViewModel messageViewModel;
  late final ScrollController scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messageViewModel = MessageViewModel(roomId: widget.roomId);
    messageViewModel.checkRealtimeConnection();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messageViewModel.streamSubscription.cancel();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MessageViewModel>(
      create: (context) {
        return messageViewModel;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 0.h,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 25.h,
                bottom: 12.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.35),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(
                      0,
                      5,
                    ),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Flexible(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FireStoreService.getMessages(widget.roomId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: MyTheme.primaryColor,
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          var messages = snapshot.data?.docs.map((e) {
                            return Message.fromJson(e.data());
                          }).toList();

                          return MessagesList(
                            messages: messages,
                            scrollController: scrollController,
                          );
                          // return Text("asd");
                        } else {
                          return CircularProgressIndicator(
                            color: MyTheme.primaryColor,
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Consumer<MessageViewModel>(
                    builder: (context, viewModel, _) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: SizedBox(
                              child: TextFormField(
                                controller:
                                    messageViewModel.messageFieldController,
                                onChanged: messageViewModel.onChangedFunction,
                                maxLines: 5,
                                minLines: 1,
                                cursorColor: MyTheme.primaryColor,
                                decoration: InputDecoration(
                                  hintText: "Type a message",
                                  hintStyle: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12.w),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                        24.r,
                                      ),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                        24.r,
                                      ),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                        24.r,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Container(
                            width: 60.h,
                            height: 60.h,
                            decoration: BoxDecoration(
                              color: messageViewModel.isEmpty ||
                                      !messageViewModel.hasInternet
                                  ? Colors.grey
                                  : MyTheme.primaryColor,
                              borderRadius: BorderRadius.circular(
                                100.r,
                              ),
                            ),
                            child: InkWell(
                              onTap: messageViewModel.isEmpty ||
                                      messageViewModel.isSending ||
                                      !messageViewModel.hasInternet
                                  ? null
                                  : () async {
                                      await messageViewModel.sendMessage();
                                      final bottomInset = scrollController
                                          .position.maxScrollExtent;
                                      scrollController.animateTo(bottomInset,
                                          duration: Duration(milliseconds: 250),
                                          curve: Curves.easeInOut);
                                    },
                              child: messageViewModel.isSending
                                  ? Center(
                                      child: SizedBox(
                                        height: 25.h,
                                        width: 25.h,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : messageViewModel.hasInternet
                                      ? const Icon(
                                          Icons.send,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.wifi_off,
                                          color: Colors.white,
                                        ),
                            ),
                          )
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
