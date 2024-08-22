import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jaimu_todo/const%20and%20utilities/const.dart';
import 'package:jaimu_todo/main.dart';

class DeleteAcc extends StatefulWidget {
  const DeleteAcc({super.key});

  @override
  State<DeleteAcc> createState() => _DeleteAccState();
}

class _DeleteAccState extends State<DeleteAcc> {
  final user = FirebaseAuth.instance.currentUser;
  bool _isSigningOut = false;

  Future<void> _signOut() async {
    if (_isSigningOut) return;

    setState(() {
      _isSigningOut = true;
    });

    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    } catch (e) {
      print('Error signing out: $e');
    } finally {
      setState(() {
        _isSigningOut = false;
      });
    }
  }

  Future<void> _deleteAccount() async {
    try {
      await user?.delete();
      await _signOut();
    } catch (e) {
      // Handle potential errors, e.g., reauthentication required
      print('Error deleting account: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete account. Please try again later.'),
        ),
      );
    }
  }

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
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Delete Account\n",
                        style: GoogleFonts.ubuntu(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: card_border),
                      ),
                      WidgetSpan(
                          child: SizedBox(
                        height: 5,
                      )),
                      TextSpan(
                        text: "Click Delete button to Delete your Account",
                        style: GoogleFonts.ubuntu(
                            fontSize: 12,
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
            onPressed: _isSigningOut
                ? null
                : () async {
                    await _deleteAccount();
                  },
            icon: Icon(Iconsax.trash),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
