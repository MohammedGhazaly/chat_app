import 'package:chat_app/utils/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCustomTextField extends StatelessWidget {
  final String text;
  final int? minLines;
  final int maxLines;
  final String? Function(String?)? validatorFunction;
  final TextEditingController textEditingController;
  const AddCustomTextField({
    super.key,
    required this.text,
    this.minLines,
    this.maxLines = 1,
    this.validatorFunction,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: validatorFunction,
      minLines: minLines,
      maxLines: maxLines,
      cursorColor: MyTheme.primaryColor,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.normal,
          fontSize: 16.sp,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: MyTheme.primaryColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
