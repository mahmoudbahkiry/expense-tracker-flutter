// ignore_for_file: prefer_const_constructors

import 'package:expense_tracker_app/views/Login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
  }

  Future<bool> isEmailVerified() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload(); // Reload user information from Firebase
    user = FirebaseAuth.instance.currentUser; // Get the updated user
    return user?.emailVerified ??
        false; // Return whether email is verified or not
  }

  Future<void> signUp() async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _firstNameController.text.trim().isEmpty ||
        _lastNameController.text.trim().isEmpty) {
      showError("Please fill in all the required fields");
      return;
    }

    try {
      // Create a user with Firebase Authentication
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification(); // Send an email verification
      showError("A verification email has been sent. Please check your email.");

      if (!await isEmailVerified()) {
        showError("Please verify your email before signing in.");
        return;
      }

      showError("A verification email has been sent. Please check your email.");
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        showError("Invalid email format");
      } else if (e.code == "user-disabled") {
        showError("User account is disabled");
      } else if (e.code == "email-already-in-use") {
        showError("This email is already in use by another account");
      } else {
        showError("An error occurred. Please try again later.");
      }
    } catch (e) {
      showError("An unexpected error occurred. Please try again later.");
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(246, 255, 255, 255),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/john-new.jpg'),
            fit: BoxFit.cover

          )
        ),


        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/undraw_my_app_re_gxtj.png',
                  height: 130,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Welcome to ExpensePro :)  ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                // Reusable text field for email
                buildTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email, color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  isEmailField: true,
                ),
                // Reusable text field for first name
                buildTextField(
                  controller: _firstNameController,
                  hintText: 'First name',
                  prefixIcon: const Icon(Icons.person, color: Colors.black),
                  keyboardType: TextInputType.text,
                ),
                // Reusable text field for last name
                buildTextField(
                  controller: _lastNameController,
                  hintText: 'Last name',
                  prefixIcon: const Icon(Icons.person, color: Colors.black),
                  keyboardType: TextInputType.text,
                ),
                // Reusable text field for password
                buildTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock, color: Colors.black),
                  obscureText: true,
                  isPassword: true,
                ),
                // Sign-up button
                buildSignUpButton(),
                // Sign-in link
                buildSignInText(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for a reusable text field
  Widget buildTextField({
    TextEditingController? controller,
    String hintText = '',
    Icon? prefixIcon,
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
          color: Color.fromARGB(255, 0, 0, 0).withOpacity(.2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: controller,
            enableSuggestions: false,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(color:Color.fromARGB(212, 0, 0, 0)),
              prefixIcon: prefixIcon,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (isEmailField) {
                if (value == null ||
                    !value.contains('@') ||
                    !value.contains('.')) {
                  return 'Please enter a valid email address';
                }
              }
              if (isPassword) {
                if (value == null || value.length < 6) {
                  return 'Minimum required characters: 6';
                }
              }
              return null; // Return null if the input is valid
            },
          ),
        ),
      ),
    );
  }

  // Widget for the sign-up button
  Widget buildSignUpButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 22, 182, 158),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: GestureDetector(
              onTap: signUp, // Call the signUp function when pressed
              child: const Text(
                'Sign up',
                style: TextStyle(
                  letterSpacing: .6,
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget for the sign-in link
  Widget buildSignInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Already have an account? ",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: const Text(
              ' Sign In',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 22, 182, 158),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
