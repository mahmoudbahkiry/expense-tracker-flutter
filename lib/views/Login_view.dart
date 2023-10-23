
// ignore_for_file: prefer_const_constructors

import 'package:expense_tracker_app/views/Home_view.dart';
import 'package:expense_tracker_app/views/Signup_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<bool> isEmailVerified() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload(); // Reload user information from Firebase
    user = FirebaseAuth.instance.currentUser; // Get the updated user
    return user?.emailVerified ?? false; // Return whether email is verified or not
  }

  void _signIn() async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      showError("Please enter both an email and a password");
      return;
    }

    try {
      // Sign in with Firebase Authentication
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      bool isVerified = await isEmailVerified(); // Check if the email is verified

      if (!isVerified) {
        showError("Your email is not verified. Please verify your email.");
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        default:
          errorMessage = 'Incorrect email or password.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(246, 255, 255, 255),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/kunj-parekh-Y5BD-H9qGvs-unsplash.jpg'),
            fit: BoxFit.cover

          )
        ),


        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Application logo
                Image.asset('images/cover.png', height: 140),
            
                // Sign-in title
                const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                // Description
                const Text(
                  'Your money , your rules',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                buildInputField(
                  isEmailField: true,
                  controller: _emailController,
                  hintText: 'Email',
                  icon: const Icon(Icons.email_outlined, color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                ),
                  const SizedBox(height: 10),
                // Password input field
                buildInputField(
                  isPassword: true,
                  controller: _passwordController,
                  hintText: 'Password',
                  icon: const Icon(Icons.lock_outline, color: Colors.black),
                  obscureText: true,
                ),
                  const SizedBox(height: 10),
                // Sign-in button
                buildSignInButton(),
                  const SizedBox(height: 10),
                // Sign-up link
                buildSignUpText(context),
                  const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for reusable input field
  Widget buildInputField({
    TextEditingController? controller,
    String hintText = '',
    Icon? icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    bool autocorrect = false,
    bool isEmailField = false,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 23, 23, 23).withOpacity(.1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: controller,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              icon: icon,
            ),
          ),
        ),
      ),
    );
  }

  // Widget for Sign-in button
  Widget buildSignInButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: _signIn,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 22, 182, 158),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Text(
              'Sign in',
              style: TextStyle(
                letterSpacing: .6,
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget for Sign-up link
  Widget buildSignUpText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Don't have an account? ",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
          ),
          GestureDetector(
            onTap: () {
              // Navigate to the SignUp page when "Sign up" is clicked
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()));
            },
            child: const Text(
              'Sign up',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 22, 182, 158),
              ),
            ),
          ),
        ],
      ),
    );
  }
}