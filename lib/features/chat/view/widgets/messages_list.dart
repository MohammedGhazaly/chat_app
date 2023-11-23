import 'package:chat_app/features/chat/view/widgets/message_widget.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/utils/my_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class MessagesList extends StatelessWidget {
  final ScrollController scrollController;
  const MessagesList({
    super.key,
    required this.messages,
    required this.scrollController,
  });

  final List<Message>? messages;

  @override
  Widget build(BuildContext context) {
    return GroupedListView<Message, DateTime>(
      controller: scrollController,
      elements: messages!,
      useStickyGroupSeparators: true,
      floatingHeader: true,
      // reverse: true,
      // order: GroupedListOrder.DESC,
      groupHeaderBuilder: (Message message) {
        return SizedBox(
          height: 40,
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r)),
              color: MyTheme.primaryColor,
              child: Padding(
                padding: EdgeInsets.all(8.h),
                child: Text(
                  DateFormat.yMMMd().format(message.date ?? DateTime.now()),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      groupBy: (message) {
        final date = message.date ?? DateTime.now();

        return DateTime(
          date.year,
          date.month,
          date.day,
        );
      },
      itemBuilder: ((context, message) {
        return MessageWidget(
          message: message,
        );
        // return Text(message.content!);
      }),
    );
  }
}
