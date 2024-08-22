import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jaimu_todo/widgets/searchbarwidget.dart';
import 'package:jaimu_todo/widgets/todocountdown.dart';
import 'package:jaimu_todo/widgets/todolist.dart';

class taskhomepage extends StatelessWidget {
  const taskhomepage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Never Forget to do work"),
        toolbarHeight: 80.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            children: [
              // search bar ==
              widgetsarc(),
              Gap(20),
              // next todo countdown
              TodoCountdownsection(),
              Gap(20),
              // todo list
              todolist()
            ],
          ),
        ),
      ),
    );
  }
}
