// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:expense_tracker_app/views/Home_view.dart';
import 'package:expense_tracker_app/views/Signup_view.dart';
import 'package:expense_tracker_app/views/forget_pass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// AuthenticationService class handles user authentication
class AuthenticationService {
  // Checks if the user's email is verified
  Future<bool> isEmailVerified(User? user) async {
    if (user == null) return false;
    await user.reload();
    user = FirebaseAuth.instance.currentUser;
    return user?.emailVerified ?? false;
  }

  // Sign in user with email and password
  Future<void> signIn(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Check if email is verified
      bool isVerified = await isEmailVerified(FirebaseAuth.instance.currentUser);

      if (!isVerified) {
        showError(context, "Your email is not verified. Please verify your email.");
      } else {
        // Navigate to the Home page on successful login
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } on FirebaseAuthException catch (e) {
      // Handle authentication exceptions
      handleAuthException(context, e);
    }
  }

  // Display an error message using a SnackBar
  void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // Handle authentication exceptions and show appropriate error messages
  void handleAuthException(BuildContext context, FirebaseAuthException e) {
    String errorMessage = '';
    switch (e.code) {
      case 'invalid-email':
        errorMessage = 'The email address is not valid.';
        break;
      default:
        errorMessage = 'Incorrect email or password.';
    }
    showError(context, errorMessage);
  }
}

// LoginScreen class is the main widget for the login screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for email and password input fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // AuthenticationService instance for handling authentication
  final AuthenticationService authService = AuthenticationService();

  @override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Sign in button callback
  void _signIn() async {
    // Check if email and password are not empty
    if (emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
      authService.showError(context, "Please enter both an email and a password");
      return;
    }

    // Attempt to sign in with provided credentials
    await authService.signIn(emailController.text, passwordController.text, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(246, 255, 255, 255),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/john.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Application logo
                Image.asset('images/undraw_Mobile_login_re_9ntv.png', height: 140),
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
                  'Your money, your rules',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                // Email input field
                buildInputField(
                  isEmailField: true,
                  controller: emailController,
                  hintText: 'Email',
                  icon: const Icon(Icons.email_outlined, color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                // Password input field
                buildInputField(
                  isPassword: true,
                  controller: passwordController,
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
                const SizedBox(height: 10),
                // Forgot password link
                ForgetPassText(context),
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
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
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
                color: Color.fromARGB(255, 22, 182, 158),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for "Forgot password?" link
Widget ForgetPassText(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ForgetPass()),
      );
    },
    child: Text(
      'Forgot password ?',
      style: TextStyle(
        color: const Color.fromARGB(255, 0, 0, 0),
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
