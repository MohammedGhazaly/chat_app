import 'package:chat_app/utils/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String? Function(String?) validatorFunction;
  final TextInputType textInputType;
  final bool isValid;
  final Function(String) onChangedFunction;
  final bool obscureText;
  const CustomTextField(
      {super.key,
      required this.labelText,
      required this.validatorFunction,
      required this.textInputType,
      required this.isValid,
      required this.onChangedFunction,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      onChanged: onChangedFunction,
      keyboardType: textInputType,
      validator: validatorFunction,
      style: TextStyle(fontSize: 18.sp, color: Colors.black),
      cursorColor: const Color(
        0xff3598DB,
      ),
      // keyboardType: ,
      decoration: InputDecoration(
        errorStyle: TextStyle(
          color: MyTheme.redColor,
        ),

        // contentPadding: const EdgeInsets.only(top: 0),
        suffixIcon: isValid == true
            ? Padding(
                padding: EdgeInsets.only(
                  top: 35.h,
                  left: 35.w,
                  right: 10.w,
                ),
                child: ImageIcon(
                  const AssetImage(
                    "assets/images/check.png",
                  ),
                  size: 20.sp,
                  color: const Color(
                    0xff3598DB,
                  ),
                ),
              )
            : null,
        labelText: labelText,
        floatingLabelStyle: TextStyle(
            fontSize: 16.sp,
            color: const Color(
              0xff3598DB,
            )),
        enabled: true,
        enabledBorder: buildBorder(),
        border: buildBorder(),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 3,
            color: Color(
              0xff3598DB,
            ),
          ),
        ),
      ),
    );
  }

  UnderlineInputBorder buildBorder() {
    return const UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Color(
          0xffD3DFEF,
        ),
      ),
    );
  }
}
