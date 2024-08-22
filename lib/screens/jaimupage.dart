import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:jaimu_todo/const%20and%20utilities/const.dart';
import 'package:jaimu_todo/screens/mainpage.dart';

class Jaimupage extends StatefulWidget {
  const Jaimupage({super.key});

  @override
  State<Jaimupage> createState() => _JaimupageState();
}

class _JaimupageState extends State<Jaimupage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: card_border,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 300, left: 10, right: 10),
            child: Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    "Welcome to Tondras Todo App 😊🖤 ",
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 60),
                    textAlign: TextAlign.center,
                  ),
                ],
                totalRepeatCount: 1,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const mainPage()));
            },
            style: const ButtonStyle(),
            child: const Text(
              "Get Started",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
