// signup_service.dart
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication
import 'package:flutter/material.dart'; // Import Flutter material library

class SignUpService {
  // Check if the user's email is verified
  Future<bool> isEmailVerified(User? user) async {
    if (user == null) return false;
    // Reload the user to get the latest information
    await user.reload();
    user = FirebaseAuth.instance.currentUser;
    // Return whether the user's email is verified or not
    return user?.emailVerified ?? false;
  }

  // Sign up a new user with provided credentials
  Future<void> signUp(
    String email, String password, String firstName, String lastName, BuildContext context) async {
    try {
      // Create a new user account
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      // Send email verification to the new user
      await user?.sendEmailVerification();

      // Show a message about the verification email
      showError(context, "A verification email has been sent. Please check your email.");

      // Check if the email is verified before allowing sign-in
      if (!await isEmailVerified(user)) {
        showError(context, "Please verify your email before signing in.");
        return;
      }

      // Show a success message
      showError(context, "A verification email has been sent. Please check your email.");
    } on FirebaseAuthException catch (e) {
      // Handle authentication exceptions
      handleAuthException(context, e);
    } catch (e) {
      // Handle unexpected errors
      showError(context, "An unexpected error occurred. Please try again later.");
    }
  }

  // Display an error message using a SnackBar
  void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // Handle authentication exceptions and display appropriate error messages
  void handleAuthException(BuildContext context, FirebaseAuthException e) {
    String errorMessage = '';
    if (e.code == "invalid-email") {
      errorMessage = "Invalid email format";
    } else if (e.code == "user-disabled") {
      errorMessage = "User account is disabled";
    } else if (e.code == "email-already-in-use") {
      errorMessage = "This email is already in use by another account";
    } else {
      errorMessage = "An error occurred. Please try again later.";
    }
    showError(context, errorMessage);
  }
}
