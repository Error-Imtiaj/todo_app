// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:jaimu_todo/const%20and%20utilities/const.dart';
import 'package:jaimu_todo/const%20and%20utilities/mytheme.dart';
import 'package:jaimu_todo/screens/TaskHomePage.dart';
import 'package:jaimu_todo/screens/settingpage.dart';
import 'package:jaimu_todo/screens/taskaddpage.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  int current_index = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myThemeData(),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: [taskhomepage(), TaskAddPage(), SettingPage()][current_index],
        bottomNavigationBar: NavigationBar(
          destinations: [
            NavigationDestination(
                icon: Icon(
                  Icons.home_filled,
                  color: card_border,
                ),
                label: "Home"),
            NavigationDestination(
                icon: Icon(
                  Icons.add_circle_outline_outlined,
                  color: card_border,
                ),
                label: "Task"),
            NavigationDestination(
                icon: Icon(
                  Icons.settings,
                  color: card_border,
                ),
                label: "Setting"),
          ],
          selectedIndex: current_index,
          onDestinationSelected: (int index) {
            setState(() {
              current_index = index;
            });
          },
        ),
      ),
    );
  }
}
