// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jaimu_todo/const%20and%20utilities/const.dart';

class StNEPc extends StatefulWidget {
  final String Conlab;
  final String Conval;
  final bool obsecuretext;
  final TextEditingController textEditingController;
  const StNEPc(
      {super.key,
      required this.Conlab,
      required this.Conval,
      this.obsecuretext = false, required this.textEditingController});

  @override
  State<StNEPc> createState() => _StNEPcState();
}

class _StNEPcState extends State<StNEPc> {
  bool _showtext = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(16),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _showtext
                    ? TextField(
                      controller: widget.textEditingController,
                        decoration: InputDecoration(
                          hintText: "Update your ${widget.Conlab}",
                        ),
                      )
                    : RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${widget.Conlab}\n",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: card_border),
                            ),
                            TextSpan(
                              text: widget.obsecuretext
                                  ? "●●●●●●●●●●"
                                  : "${widget.Conval}",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: card_border),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _showtext = !_showtext;
              });
            },
            icon: _showtext ? Icon(Iconsax.tick_circle) : Icon(Iconsax.edit),
          ),
        ],
      ),
    );
  }
}
