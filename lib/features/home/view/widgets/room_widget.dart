import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoomWidget extends StatelessWidget {
  final String roomType;
  final String roomName;
  final int membersCount;
  const RoomWidget(
      {super.key,
      required this.roomType,
      required this.roomName,
      required this.membersCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(
              0,
              5,
            ),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Image.asset(
              getImage(roomType),
              width: 125.h,
              height: 125.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              roomName,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              membersCount == 1 ? "1 Member" : "$membersCount Members",
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
            )
          ],
        ),
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
