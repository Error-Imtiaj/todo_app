import 'package:flutter/material.dart';

class Descriptionwidget_taskaddpage extends StatelessWidget {
  const Descriptionwidget_taskaddpage({
    super.key,
    required this.subtitletexteditioncontrollar,
  });

  final TextEditingController subtitletexteditioncontrollar;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Description can't be empty";
        }
        else{
          return null;
        }
      },
      controller: subtitletexteditioncontrollar,
      maxLength: 1000,
      minLines: 4,
      maxLines: null,
      decoration: InputDecoration(
        labelText: "Description",
        border: OutlineInputBorder(),
        hintText: "Write your Subtitle",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelAlignment: FloatingLabelAlignment.start,
      ),
    );
  }
}
