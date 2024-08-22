// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaimu_todo/const%20and%20utilities/const.dart';

ThemeData myThemeData() {
  return ThemeData(
    primaryColor: card_border,
    textTheme: GoogleFonts.ubuntuTextTheme(),
    appBarTheme: AppBarTheme(
      color: card_little_text,
      titleTextStyle:
          GoogleFonts.ubuntu(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    scaffoldBackgroundColor: Color(0XFFe7f7ff),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(card_border),
        iconColor: WidgetStatePropertyAll(Colors.white),
      ),
    ),

    // text style
    
  );
}
