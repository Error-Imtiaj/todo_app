import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jaimu_todo/const%20and%20utilities/const.dart';
import 'package:jaimu_todo/const%20and%20utilities/image_add_firebase_store.dart';
import 'package:jaimu_todo/const%20and%20utilities/image_picker_utilities.dart';
import 'package:jaimu_todo/main.dart';
import 'package:jaimu_todo/widgets/deleteaccount.dart';
import 'package:jaimu_todo/widgets/setting_page_name_email_pass_container.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _isSigningOut = false;
  bool _isLoading = false;
  Uint8List? _img;
  final email = FirebaseAuth.instance.currentUser?.email;
  final username = FirebaseAuth.instance.currentUser?.uid;
  String? _imgUrl;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    String? imageUrl = await StoreImage().getImageUrl();
    if (imageUrl != null) {
      setState(() {
        _imgUrl = imageUrl;
      });
    }
  }

  void _pickedimage() async {
    final Uint8List? image = await pickImagfe();
    if (image != null) {
      setState(() {
        _img = image;
      });
    }
  }

  Future<void> saveProfile() async {
    if (_img != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        String resp = await StoreImage().SaveiMAGE(
          file: _img!,
          email: email ?? 'No Email',
          username: username.toString(),
        );

        if (resp == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Profile saved successfully!',
                style: GoogleFonts.ubuntu(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to save profile: $resp',
                style: GoogleFonts.ubuntu(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error saving profile: $e',
              style: GoogleFonts.ubuntu(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select an image first',
            style: GoogleFonts.ubuntu(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final TextEditingController Nametextctrl = TextEditingController();
    final TextEditingController emailctrl = TextEditingController();
    final TextEditingController passctrl = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Setting"),
        toolbarHeight: 80.0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ElevatedButton(
              onPressed: _isSigningOut ? null : _signOut,
              style: ElevatedButton.styleFrom(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "Log Out",
                    style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold),
                  ),
                  Gap(5),
                  Icon(Iconsax.logout),
                ],
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Picture container
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _imgUrl != null
                            ? CircleAvatar(
                                backgroundColor: card_bg_color,
                                backgroundImage: NetworkImage(_imgUrl!),
                                radius: 64,
                              )
                            : CircleAvatar(
                                backgroundColor: card_bg_color,
                                child: Icon(
                                  Iconsax.user,
                                  size: 60,
                                  color: card_border,
                                ),
                                radius: 64,
                              ),
                        Gap(10),
                        ElevatedButton(
                          onPressed: () {
                            _pickedimage();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: card_border,
                            shape: BeveledRectangleBorder(),
                          ),
                          child: Text(
                            "Edit Photo",
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),

                    // Name show and edit container
                    StNEPc(
                      Conlab: 'Name',
                      Conval: username.toString(),
                      textEditingController: Nametextctrl,
                    ),
                    // Email show and edit container
                    StNEPc(
                      Conlab: 'Email',
                      Conval: email.toString(),
                      textEditingController: emailctrl,
                    ),
                    // Password show and edit container
                    StNEPc(
                      Conlab: 'Password',
                      Conval: '123456',
                      obsecuretext: true,
                      textEditingController: passctrl,
                    ),
                    // Delete container
                    DeleteAcc(),

                    // Save
                    ElevatedButton(
                      onPressed: () {
                        saveProfile();
                      },
                      child: Text("Save"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
