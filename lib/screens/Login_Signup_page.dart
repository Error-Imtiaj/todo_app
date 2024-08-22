import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jaimu_todo/const%20and%20utilities/const.dart';

import '../const and utilities/image_add_firebase_store.dart';

class MyLoginSignupPage extends StatefulWidget {
  const MyLoginSignupPage({Key? key}) : super(key: key);

  @override
  State<MyLoginSignupPage> createState() => _MyLoginSignupPageState();
}

class _MyLoginSignupPageState extends State<MyLoginSignupPage> {
  bool _haveAccount = true;
  bool _notSeePass = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // sign in method firebase
  void signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        // progress bar
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          },
        );
        // sign in
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);

        // stop loading
        Navigator.of(context, rootNavigator: true).pop();
        successfullySignedUp("You have successfully signed In");
      } on FirebaseAuthException catch (e) {
        // stop loading
        Navigator.of(context, rootNavigator: true).pop();

        // error exceptions
        if (e.code == 'user-not-found') {
          handleError("Wrong email please try again or create account");
        } else if (e.code == 'wrong-password') {
          handleError("Wrong Password please try again");
        } else {
          handleError("please provide a valid email address and password");
        }
      } catch (e) {
        Navigator.of(context, rootNavigator: true).pop();
        handleError("An error occurred");
      }
    }
  }

  // dialogue error
  void handleError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.ubuntu(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  // signed up successfully dialogue
  void successfullySignedUp(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.ubuntu(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Create user method
  void createUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Show progress bar if the widget is still mounted
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Center(child: CircularProgressIndicator());
            },
          );
        }

        // Create user with email and password
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Dismiss the progress bar and show success message if the widget is still mounted
        if (mounted) {
          Navigator.of(context, rootNavigator: true)
              .pop(); // Dismiss the progress dialog
          successfullySignedUp("You have successfully signed up");
        }
      } on FirebaseAuthException catch (e) {
        // Handle Firebase Auth specific exceptions
        if (mounted) {
          Navigator.of(context, rootNavigator: true)
              .pop(); // Dismiss the progress dialog
          if (e.code == 'weak-password') {
            handleError("The password you provided is too weak");
          } else if (e.code == 'email-already-in-use') {
            handleError("The email you have entered has already been used");
          }
        }
      } catch (e) {
        // Handle general exceptions
        if (mounted) {
          Navigator.of(context, rootNavigator: true)
              .pop(); // Dismiss the progress dialog
          handleError("An error occurred");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: card_border,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(
                      12,
                    ),
                  ),
                ),
                width: double.infinity,
                height: 300,
                child: const Icon(
                  Iconsax.user_add,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              const Gap(20),
              !_haveAccount
                  ? Text(
                      textAlign: TextAlign.start,
                      "It's good to have you \nwith us!",
                      style: GoogleFonts.ubuntu(
                        color: card_little_text,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Text(
                      "Welcome Back!",
                      style: GoogleFonts.ubuntu(
                        color: card_little_text,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.message),
                    hintText: "Email",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if ((value.toString().contains('@'))) {
                      return null;
                    } else {
                      return 'Please enter a valid email address';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: _notSeePass,
                  validator: (value) {
                    if (value.toString().length < 8) {
                      return 'Password less than 8 Char';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.lock),
                    suffixIcon: IconButton(
                        style: IconButton.styleFrom(
                            splashFactory: NoSplash.splashFactory),
                        onPressed: () {
                          setState(() {
                            _notSeePass = !_notSeePass;
                          });
                        },
                        icon: _notSeePass
                            ? const Icon(Iconsax.eye)
                            : const Icon(Iconsax.eye_slash)),
                    hintText: "Password",
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                ),
              ),
              const Gap(10),
              ElevatedButton(
                onPressed: () {
                  _haveAccount ? signIn() : createUser();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: card_border,
                  shape: const RoundedRectangleBorder(),
                ),
                child: Text(
                  _haveAccount ? "Log In" : "Sign Up",
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                style:
                    TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
                onPressed: () {
                  setState(() {
                    _haveAccount = !_haveAccount;
                  });
                },
                child: _haveAccount
                    ? const Text("Don't have an account? Create One")
                    : const Text("Have an account? Log in "),
              )
            ],
          ),
        ),
      ),
    );
  }
}
