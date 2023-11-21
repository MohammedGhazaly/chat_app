import 'package:chat_app/features/home/view/home_view.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popover/popover.dart';

class CustomAppBarActions extends StatelessWidget {
  final String roomId;
  const CustomAppBarActions({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: Icon(
        Icons.more_vert,
        size: 36.sp,
      ),
      onPressed: () {
        showPopover(
            direction: PopoverDirection.top,
            width: 180.w,
            height: 50.h,

            // arrowHeight: 25,
            // arrowWidth: 25,
            // arrowHeight: 50.w,
            // arrowWidth: 50.w,

            radius: 0,
            context: context,
            bodyBuilder: (context) {
              return InkWell(
                onTap: () async {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  await FireStoreService.removeUserFromRoom(roomId);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 10, top: 5.w),
                  child: Text(
                    "Leave room",
                    style: TextStyle(fontSize: 16.sp, color: Colors.black),
                  ),
                ),
              );
            });
      },
    );
  }
}
