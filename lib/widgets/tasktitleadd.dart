import 'package:flutter/material.dart';

class Titlewidget_taskaddpage extends StatelessWidget {
  const Titlewidget_taskaddpage({
    super.key,
    required this.titletexteditioncontrollar,
  });

  final TextEditingController titletexteditioncontrollar;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Title can't be empty";
        }
        else{
          return null;
        }
      },
      controller: titletexteditioncontrollar,
      decoration: InputDecoration(
        labelText: "Title",
        border: OutlineInputBorder(),
        hintText: "Write your title",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelAlignment: FloatingLabelAlignment.start,
      ),
    );
  }
}
