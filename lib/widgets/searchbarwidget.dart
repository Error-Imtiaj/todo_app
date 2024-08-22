import 'package:flutter/material.dart';
import 'package:jaimu_todo/const%20and%20utilities/const.dart';

class widgetsarc extends StatelessWidget {
  const widgetsarc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "search here",
        hintStyle: TextStyle(color: const Color.fromARGB(255, 5, 3, 3)),
        icon: IconButton.filled(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
        enabledBorder: myborder(),
        focusedBorder: myborder(),
      ),
    );
  }
}

