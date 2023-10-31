// Flutter imports
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  // Initialize controllers and FirebaseAuth instance
  final emailControllerReset = TextEditingController();
  @override
  void dispose() {
  
    emailControllerReset.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
    
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Forgot password? ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 26,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset('images/undraw_Forgot_password_re_hxwm.png',
                    height: 200),
              ),
              SizedBox(height: 20),
              Text(
                'Enter the email address associated with your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 26,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'We will email you with a link to reset your password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w100,
                      color: Color.fromARGB(107, 105, 105, 105)),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: emailControllerReset,
                  decoration: InputDecoration(
                    hintText: 'Type your email ..',
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 22, 182, 158)),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  sendResetEmail(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(75, 0, 255, 229)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Text('Send'),
              ),
              SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }

// rest password function
  Future sendResetEmail(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(child: CircularProgressIndicator()),
  );
  String errorMessage = "";
  bool verified = await isEmailVerified();

  if (!verified) {
    errorMessage = ('Verify email before you can reset the password');

    // Close the loading dialog
    Navigator.of(context).pop();

    // Show the error message using SnackBar
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(errorMessage)));
  } else {
    try {
      final email = emailControllerReset.text.trim();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      // Close the loading dialog
      Navigator.of(context).pop();

      // Show a success message using SnackBar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Password reset email sent successfully.')));

      // Optionally, you can navigate back to the previous screen or perform any other actions.
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        errorMessage = ("Invalid email");
      } else {
        errorMessage = ("Incorrect email");
      }

      // Close the loading dialog
      Navigator.of(context).pop();

      // Show the error message using SnackBar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }
}


  Future<bool> isEmailVerified() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload(); // Reload user information from Firebase
    user = FirebaseAuth.instance.currentUser; // Get the updated user
    return user?.emailVerified ??
        false; // Return whether email is verified or not
  }
}
