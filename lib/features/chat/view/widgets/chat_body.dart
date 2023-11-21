import 'package:chat_app/features/chat/view_model/chat_view_model.dart';
import 'package:chat_app/utils/my_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChatBody extends StatelessWidget {
  final String roomId;
  const ChatBody({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MessageViewModel>(
      create: (context) {
        return MessageViewModel(roomId: roomId);
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
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Consumer<MessageViewModel>(
                      builder: (context, messageViewModel, _) {
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
                            color: messageViewModel.isEmpty
                                ? Colors.grey
                                : MyTheme.primaryColor,
                            borderRadius: BorderRadius.circular(
                              100.r,
                            ),
                          ),
                          child: InkWell(
                            onTap: messageViewModel.isEmpty
                                ? null
                                : messageViewModel.sendMessage,
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                          // child: InkWell(
                          //   onTap: () {},
                          //   child: IconButton(
                          //     padding: EdgeInsets.all(0),
                          //     onPressed: () {},
                          //     icon: Icon(
                          //       Icons.send,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // ),
                        )
                      ],
                    );
                  })
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
