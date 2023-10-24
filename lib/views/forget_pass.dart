// Flutter imports
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



class ForgetPass extends StatefulWidget {
  const ForgetPass({Key? key}) : super(key: key);

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  // Initialize controllers and FirebaseAuth instance
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;



  // Function to check if email is valid and registered
  Future<bool> isEmailValidAndRegistered(String email) async {
    try {
      // Check if the email exists in your user database
      final user = (await _auth.fetchSignInMethodsForEmail(email)).first;
      return user == 'password'; //ensure that the email provided is associated with a 
      //registered user who can request a password reset. If it's associated with a 
      //'password' sign-in method
    
    
    } catch (e) {
      return false; // Error occurred, email is not registered
    }
  }

  // Function to show SnackBar messages
  void showSnackBarMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Function to send a reset email
  Future<void> sendResetEmail() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      showSnackBarMessage('Please type in your email.');
      return;
    }

    if (await isEmailValidAndRegistered(email)) {
      try {
        await _auth.sendPasswordResetEmail(email: email);
        showSnackBarMessage('Password reset email sent successfully.');
      } catch (e) {
        showSnackBarMessage('An error occurred. Please try again later.');
      }
    } else {
      showSnackBarMessage('Email not found or not registered.');
    }
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
                style: TextStyle(fontSize: 26, fontFamily: 'Nunito', fontWeight: FontWeight.w600),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset('images/undraw_Forgot_password_re_hxwm.png', height: 200),
              ),
              SizedBox(height: 20),
              Text(
                'Enter the email address associated with your account',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontFamily: 'Nunito', fontWeight: FontWeight.w800),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'We will email you with a link to reset your password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontFamily: 'Nunito', fontWeight: FontWeight.w100, color: Color.fromARGB(107, 105, 105, 105)),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Type your email ..',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 22, 182, 158)),
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
                onPressed: sendResetEmail,
                style: ButtonStyle(
                 backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(75, 0, 255, 229)),
                 foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
}
