import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jaimu_todo/const%20and%20utilities/const.dart';
import 'package:jaimu_todo/widgets/descriptiontaskadd.dart';
import 'package:jaimu_todo/widgets/tasktitleadd.dart';

class TaskUpdate extends StatefulWidget {
  final String taskId;

  const TaskUpdate({super.key, required this.taskId});

  @override
  State<TaskUpdate> createState() => _TaskUpdateState();
}

class _TaskUpdateState extends State<TaskUpdate> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _userId = FirebaseAuth.instance.currentUser!.uid;

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _formattedDate;
  String? _formattedTime;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final document = await FirebaseFirestore.instance
        .collection('users')
        .doc(_userId)
        .collection('Todo')
        .doc(widget.taskId)
        .get();

    _titleController.text = document['Title'];
    _descriptionController.text = document['Description'];
    _formattedDate = document['Date'];
    _formattedTime = document['Time'];

    setState(() {}); // Triggers a rebuild to show the loaded data
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _formattedDate = "${picked.day} / ${picked.month} / ${picked.year}";
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _formattedTime = "${picked.hour} : ${picked.minute}";
      });
    }
  }

  Future<void> _updateTask() async {
    if (_formKey.currentState!.validate()) {
      loading(context);
      if (_formattedDate != null && _formattedTime != null) {
        // Show loading dialog

        await FirebaseFirestore.instance
            .collection('users')
            .doc(_userId)
            .collection('Todo')
            .doc(widget.taskId)
            .update({
          "Title": _titleController.text,
          "Description": _descriptionController.text,
          "Date": _formattedDate,
          "Time": _formattedTime,
        });

        Navigator.of(rootNavigator: true, context)
            .pop(); // Close loading dialog
        showSuccessMessage("Task Updated Successfully", context);
      } else {
        Navigator.of(rootNavigator: true, context).pop();
        showErrorMessage("Please select a date and time", context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Update Task"),
        leading: IconButton(
          iconSize: 20.0, // Set the desired size here
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        toolbarHeight: 80.0,
      ),
      body: _formattedDate != null && _formattedTime != null
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Gap(10),
                      Titlewidget_taskaddpage(
                        titletexteditioncontrollar: _titleController,
                      ),
                      Gap(10),
                      Descriptionwidget_taskaddpage(
                        subtitletexteditioncontrollar: _descriptionController,
                      ),
                      Gap(10),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: _pickDate,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: card_border,
                              shape: ContinuousRectangleBorder(),
                            ),
                            child: Text(
                              "Select Date",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black)),
                            child: Text(
                              _formattedDate ?? "No date selected",
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        ],
                      ),
                      Gap(10),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: _pickTime,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: card_border,
                              shape: ContinuousRectangleBorder(),
                            ),
                            child: Text(
                              "Select Time",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black)),
                            child: Text(
                              _formattedTime ?? "No time selected",
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        ],
                      ),
                      Gap(10),
                      ElevatedButton(
                        onPressed: _updateTask,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: card_border,
                          shape: ContinuousRectangleBorder(),
                        ),
                        child: Text(
                          "Update Task",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
