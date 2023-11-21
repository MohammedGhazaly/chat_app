import 'package:chat_app/features/home/view/widgets/room_widget.dart';
import 'package:chat_app/features/room_intro/view/room_intro_view.dart';
import 'package:chat_app/model/chat_room.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:chat_app/utils/my_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoggedUserRooms extends StatelessWidget {
  const LoggedUserRooms({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.h,
        ),
        StreamBuilder<QuerySnapshot<ChatRoom>>(
          stream: FireStoreService.getLoggedUsersRoom(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: MyTheme.primaryColor,
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Expanded(
                child: Center(
                  child: Text(snapshot.error.toString()),
                ),
              );
            } else {
              var rooms = snapshot.data?.docs.map((e) {
                return e.data();
              }).toList();
              if (rooms!.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      "No rooms found",
                      style: TextStyle(
                        color: MyTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                );
              }
              return Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(20.h),
                  itemCount: rooms!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 140 / 180,
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 20.w),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoomIntroView.routeName,
                            arguments: rooms[index]);
                      },
                      child: RoomWidget(
                        roomType: rooms[index].roomType,
                        membersCount: rooms[index].membersCount!,
                        roomName: rooms[index].title,
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
