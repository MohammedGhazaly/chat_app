import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAuthButton extends StatelessWidget {
  final Function()? onTapFunction;
  final String buttonText;
  final bool isLoading;
  const CustomAuthButton(
      {super.key,
      this.onTapFunction,
      required this.buttonText,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunction,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: const Color(
            0xff3598DB,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              buttonText,
              style: const TextStyle(color: Colors.white),
            ),
            isLoading == true
                ? SizedBox(
                    height: 32.sp,
                    width: 32.sp,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Icon(
                    Icons.east,
                    color: Colors.white,
                  )
          ],
        ),
      ),
    );
  }
}
