import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class CustomDialogs {
  static void showSuccessDialog({
    required BuildContext context,
    required String title,
    required String desc,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      title: title,
      desc: desc,
    ).show();
  }

  static void showFailureDialog({
    required BuildContext context,
    required String title,
    required String desc,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: title,
      desc: desc,
    ).show();
  }
}
