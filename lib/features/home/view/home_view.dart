import 'package:chat_app/features/add_room/view/add_room_view.dart';
import 'package:chat_app/features/auth/view/login/login_view.dart';
import 'package:chat_app/features/home/view/widgets/all_rooms.dart';
import 'package:chat_app/features/home/view/widgets/logged_user_rooms.dart';
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
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
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
            bottom: TabBar(
              splashFactory: NoSplash.splashFactory,
              dividerColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              indicatorWeight: 2,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 30.w),
              tabs: [
                Tab(
                  text: "My rooms",
                ),
                Tab(
                  text: "Browse",
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                50.r,
              ),
            ),
            backgroundColor: MyTheme.primaryColor,
            onPressed: () async {
              Navigator.pushNamed(context, AddRoomView.routeName);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: TabBarView(
            children: [
              LoggedUserRooms(),
              AllRooms(),
            ],
          ),
        ),
      ),
    );
  }
}
