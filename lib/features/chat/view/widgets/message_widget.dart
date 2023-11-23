import 'package:chat_app/model/message.dart';
import 'package:chat_app/utils/my_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return message.senderId == FirebaseAuth.instance.currentUser!.uid
        ? Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(
                bottom: 12.h,
                left: 64.w,
              ),
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                color: MyTheme.primaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(16.r),
                  topLeft: Radius.circular(16.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.content!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    DateFormat.jm().format(message.date ?? DateTime.now()),
                    style: TextStyle(
                      fontSize: 10.sp,
                    ),
                  )
                ],
              ),
            ),
          )
        : Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(bottom: 12.h, right: 64.w),
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                boxShadow: [],
                color: Color.fromARGB(255, 223, 222, 222),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                  topLeft: Radius.circular(16.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.senderName!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: MyTheme.primaryColor,
                    ),
                  ),
                  Text(
                    message.content!,
                    style: TextStyle(
                      color: Color(0xff787993),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      DateFormat.jm().format(message.date ?? DateTime.now()),
                      style: TextStyle(
                        fontSize: 10.sp,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
