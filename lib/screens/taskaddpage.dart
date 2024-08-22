// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jaimu_todo/const%20and%20utilities/const.dart';
import 'package:jaimu_todo/widgets/descriptiontaskadd.dart';
import 'package:jaimu_todo/widgets/tasktitleadd.dart';

class TaskAddPage extends StatefulWidget {
  const TaskAddPage({super.key});

  @override
  State<TaskAddPage> createState() => _TaskAddPageState();
}

class _TaskAddPageState extends State<TaskAddPage> {
  // date picker method
  Row Showtimepickermethod() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            _showtimepicker();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: card_border,
            shape: RoundedRectangleBorder(),
          ),
          child: Text(
            "Select Time",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.all(8),
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
          child: Text(
            time != null
                ? "${time!.hour} : ${time!.minute}"
                : "No Time selected", // added null check
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }

  // time picker method
  Row Showdatepickermethod() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            _showdatepicker();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: card_border,
            shape: RoundedRectangleBorder(),
          ),
          child: Text(
            "Select date",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.all(8),
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
          child: Text(
            now != null
                ? "${now!.day} / ${now!.month} / ${now!.year} "
                : "No date selected", // added null check
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }

  // picked date
  void _showdatepicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    ).then((value) {
      setState(() {
        now = value;
      });
    });
  }

  // picked Time
  void _showtimepicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((onValue) {
      setState(() {
        time = onValue;
      });
    });
  }

  // variables
  final userId = FirebaseAuth.instance.currentUser!.uid;
  DateTime? now; // made now nullable
  TimeOfDay? time;
  TextEditingController titletexteditioncontrollar = TextEditingController();
  TextEditingController subtitletexteditioncontrollar = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add your Task"),
        toolbarHeight: 80.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Gap(10),
                Titlewidget_taskaddpage(
                    titletexteditioncontrollar: titletexteditioncontrollar),
                Gap(10),
                Descriptionwidget_taskaddpage(
                    subtitletexteditioncontrollar:
                        subtitletexteditioncontrollar),
                Gap(10),
                Showdatepickermethod(),
                Gap(10),
                Showtimepickermethod(),
                Gap(10),
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      // Loading
                      loading(context);

                      // Send task to Firestore user collection
                      if (now != null && time != null) {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .collection('Todo')
                            .add({
                          "Title": titletexteditioncontrollar.text,
                          "Description": subtitletexteditioncontrollar.text,
                          "Date": "${now!.day} / ${now!.month} / ${now!.year} ",
                          "Time": "${time!.hour} : ${time!.minute}",
                        }).then((value) {
                          titletexteditioncontrollar.clear();
                          subtitletexteditioncontrollar.clear();
                          setState(() {
                            now = null;
                            time = null;
                          });
                          Navigator.of(rootNavigator: true, context).pop();
                          showSuccessMessage(
                              "Task Added Successfully", context);
                        });
                      } else {
                        Navigator.of(rootNavigator: true, context).pop();
                        showErrorMessage(
                            "Please select date and time", context);
                      }
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(card_border)),
                  child: Text(
                    "Add Task",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
