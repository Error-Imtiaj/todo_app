import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color card_bg_color = Color(0xffb0e0ff);
const Color card_border = Color(0xff192a56);
const Color card_little_text = Color(0xff0c3da3);

OutlineInputBorder myborder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: card_border,
      width: 2,
    ),
    borderRadius: BorderRadius.circular(12),
  );
}

// textstyle

TextStyle mytextstyle() {
  return GoogleFonts.ubuntu(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

// my box decoratoion

BoxDecoration myboxdecoration() {
  return BoxDecoration(
      color: card_border,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: card_border,
          spreadRadius: 0,
          blurRadius: 2,
          blurStyle: BlurStyle.outer,
          offset: Offset.fromDirection(0, 5),
        )
      ]);
}

// todo list tile
ListTile mylisttile() {
  return ListTile(tileColor: card_bg_color, title: Text("Hello"));
}

// sucess message

void showSuccessMessage(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: GoogleFonts.ubuntu(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.green,
    ),
  );
}
// sucess message

void showErrorMessage(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: GoogleFonts.ubuntu(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.red,
    ),
  );
}

// progress bar

void loading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const Center(child: CircularProgressIndicator());
    },
  );
}


