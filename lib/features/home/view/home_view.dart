import 'package:chat_app/features/add_room/view/add_room_view.dart';
import 'package:chat_app/features/auth/view/login/login_view.dart';
import 'package:chat_app/features/home/view/widgets/room_widget.dart';
import 'package:chat_app/features/room_intro/view/room_intro_view.dart';
import 'package:chat_app/model/chat_room.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:chat_app/utils/my_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatelessWidget {
  static String routeName = "home-view";

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Chat app",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              padding: EdgeInsets.only(right: 24.w),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (!context.mounted) return;
                Navigator.pushReplacementNamed(context, LoginView.routeName);
              },
              icon: Icon(
                Icons.logout_outlined,
                size: 32.sp,
              ),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              50.r,
            ),
          ),
          backgroundColor: MyTheme.primaryColor,
          onPressed: () {
            Navigator.pushNamed(context, AddRoomView.routeName);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: StreamBuilder<QuerySnapshot<ChatRoom>>(
          stream: FireStoreService.getRooms(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: MyTheme.primaryColor,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              var rooms = snapshot.data?.docs.map((e) {
                return e.data();
              }).toList();
              if (rooms!.isEmpty) {
                return Center(
                  child: Text(
                    "No rooms found",
                    style: TextStyle(
                      color: MyTheme.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                    ),
                  ),
                );
              }
              return GridView.builder(
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
              );
            }
          },
        ),
      ),
    );
  }
}
