import 'package:flutter/material.dart';
import 'package:jaimu_todo/const%20and%20utilities/const.dart';

class TodoCountdownsection extends StatelessWidget {
  const TodoCountdownsection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // text
          Container(
            height: double.infinity,
            width: 220,
            decoration: myboxdecoration(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Next Task \nStart in ",
                style: mytextstyle(),
              ),
            ),
          ),
    
          // countdown
          Container(
            width: 130,
            height: double.infinity,
            decoration: myboxdecoration(),
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 30),
              child: Text(
                "8:35",
                style: mytextstyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
