import 'package:chat_app/features/chat/view/chat_view.dart';
import 'package:chat_app/model/chat_room.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:chat_app/utils/my_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoomIntroView extends StatelessWidget {
  static String routeName = "room-intro";
  const RoomIntroView({super.key});

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
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
            padding: EdgeInsets.only(
                top: 25.h, left: 25.w, right: 25.w, bottom: 50.h),
            width: double.infinity,
            // height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(
                    0,
                    5,
                  ),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  "Hello, Welcome to our chat room.",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xff303030),
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  roomArgs.title,
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: Color(0xff303030),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Image.asset(
                  getImage(roomArgs.roomType),
                  height: 200.h,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  roomArgs.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff7F7F7F),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(
                  height: 35.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: SizedBox(
                    height: 55.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                          8.r,
                        )),
                        backgroundColor: MyTheme.primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        bool isInRoom =
                            await FireStoreService.checkIfUserInRoom(
                                roomArgs.roomId!);
                        if (isInRoom) {
                          if (!context.mounted) return;
                          Navigator.pushReplacementNamed(
                              context, ChatView.routeName,
                              arguments: roomArgs);
                        } else {
                          FireStoreService.incrementMembers(roomArgs.roomId!);
                          // FireStoreService.addRoomToUser(
                          //     FirebaseAuth.instance.currentUser!.uid, roomArgs);
                          await FireStoreService.addUserToRoom(
                              roomId: roomArgs.roomId!,
                              userId: FirebaseAuth.instance.currentUser!.uid);
                          if (!context.mounted) return;

                          Navigator.pushReplacementNamed(
                              context, ChatView.routeName,
                              arguments: roomArgs);
                        }
                      },
                      child: Text(
                        "Join",
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  String getImage(String roomType) {
    switch (roomType) {
      case "Sports":
        return "assets/images/sports.png";
      case "Movies":
        return "assets/images/movies.png";
      default:
        return "assets/images/music.png";
    }
  }
}
