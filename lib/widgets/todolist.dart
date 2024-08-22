import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jaimu_todo/const%20and%20utilities/const.dart';
import 'package:jaimu_todo/screens/taskUpdate.dart';
import 'package:jaimu_todo/screens/taskaddpage.dart';

class todolist extends StatelessWidget {
  const todolist({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Todo')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading....');

          default:
            return Column(
              children: List.generate(snapshot.data!.docs.length, (index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                return Container(
                  height: 100,
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(12),
                      color: card_border,
                    ),
                    child: GestureDetector(
                      onLongPress: () {
                        print(document.id);
                        // Edit task dialoge
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            title: Text(
                              "Edit Your Task",
                              style: GoogleFonts.ubuntu(
                                fontSize: 20,
                                color: card_border,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            actions: [
                              // no button
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(
                                      rootNavigator: true,
                                      context,
                                    ).pop();
                                  },
                                  child: Text(
                                    "No",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 16,
                                      color: card_border,
                                    ),
                                  )),

                              // yes button

                              TextButton(
                                onPressed: () {
                                  Navigator.of(
                                    rootNavigator: true,
                                    context,
                                  ).pop(true);
                                },
                                child: Text(
                                  "Yes",
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 16,
                                    color: card_border,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).then((value) {
                          //  task update

                          if (value == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskUpdate(
                                  taskId: document.id,
                                ),
                              ),
                            );
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${document['Title']}\n",
                                    style: GoogleFonts.ubuntu(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  WidgetSpan(
                                      child: SizedBox(
                                    height: 25,
                                  )),
                                  TextSpan(
                                    text:
                                        "${document['Description'].split(' ').take(3).join(' ')}\n",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 20, top: 20),
                            child: RichText(
                              textAlign: TextAlign.end,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${document['Date']}\n",
                                    style: GoogleFonts.ubuntu(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  WidgetSpan(
                                      child: SizedBox(
                                    height: 25,
                                  )),
                                  TextSpan(
                                    text: "${document['Time']}\n",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),

                            // Deelete button

                            child: IconButton(
                              onPressed: () {
                                //Delete  Alert dia logue

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    title: Text(
                                      "Are you sure?",
                                      style: GoogleFonts.ubuntu(
                                        fontSize: 20,
                                        color: card_border,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    actions: [
                                      // no button
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(
                                              rootNavigator: true,
                                              context,
                                            ).pop();
                                          },
                                          child: Text(
                                            "No",
                                            style: GoogleFonts.ubuntu(
                                              fontSize: 16,
                                              color: card_border,
                                            ),
                                          )),

                                      // yes button

                                      TextButton(
                                        onPressed: () async {
                                          Navigator.of(
                                            rootNavigator: true,
                                            context,
                                          ).pop();
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .collection('Todo')
                                              .doc(document.id)
                                              .delete();
                                        },
                                        child: Text(
                                          "Yes",
                                          style: GoogleFonts.ubuntu(
                                            fontSize: 16,
                                            color: card_border,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              icon: Icon(
                                Iconsax.trash,
                                color: card_border,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
        }
      },
    );
  }
}
