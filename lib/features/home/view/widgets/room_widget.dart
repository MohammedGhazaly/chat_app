import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoomWidget extends StatelessWidget {
  const RoomWidget({super.key});

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
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Image.asset(
            "assets/images/movies.png",
            width: 125.h,
            height: 125.h,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "The movies zone",
            maxLines: 2,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "13 Members",
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
