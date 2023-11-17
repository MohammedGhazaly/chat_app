import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static Color redColor = const Color(0xffEC4B4B);
  static Color primaryColor = const Color(0xff3598DB);
  final ThemeData mainTheme = ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
