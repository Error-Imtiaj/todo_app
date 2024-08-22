// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jaimu_todo/screens/jaimupage.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final List<String> jumu = ["J", "A", "I", "M", "U"];
  final List<Color> jumu_color = [
    Color(0xffEA2027),
    Color(0xffEE5A24),
    Color(0xffF79F1F),
    Color(0xffA3CB38),
    Color(0xff1B1464),
  ];
  int indexin = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          jumu[indexin],
          style: TextStyle(
            fontSize: 300,
            fontWeight: FontWeight.bold,
            color: jumu_color[indexin],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          indexin != 0
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: IconButton(
                    onPressed: () {
                      setState(
                        () {
                          if (indexin != 0) {
                            indexin--;
                          }
                        },
                      );
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      size: 20,
                    ),
                  ),
                )
              : SizedBox(),
          IconButton(
            onPressed: () {
              setState(
                () {
                  if (indexin < jumu.length - 1) {
                    indexin++;
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Jaimupage(),
                      ),
                    );
                  }
                },
              );
            },
            icon: Icon(
              Icons.keyboard_arrow_right,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
