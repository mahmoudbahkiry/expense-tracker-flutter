import 'package:expense_tracker_project/views/home_page_view.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication
import 'package:flutter/material.dart'; // Import Flutter material library

class AuthenticationService {
  // Check if the user's email is verified
  Future<bool> isEmailVerified(User? user) async {
    if (user == null) return false;
    // Reload the user to get the latest information
    await user.reload();
    user = FirebaseAuth.instance.currentUser;
    // Return whether the user's email is verified or not
    return user?.emailVerified ?? false;
  }

  // Sign in user with email and password
  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      // Attempt to sign in using provided credentials
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Check if the user's email is verified
      bool isVerified =
          await isEmailVerified(FirebaseAuth.instance.currentUser);

      if (!isVerified) {
        // If email is not verified, show an error message
        showError(
            context, "Your email is not verified. Please verify your email.");
      } else {
        // If email is verified, navigate to the Home page
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomePageView()));
      }
    } on FirebaseAuthException catch (e) {
      // Handle authentication exceptions
      handleAuthException(context, e);
    }
  }

  // Display an error message using a SnackBar
  void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
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
