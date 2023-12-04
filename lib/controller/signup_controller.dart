import 'package:expense_tracker_project/model/signup_service.dart';
import 'package:flutter/material.dart';

// Controller class for handling sign-up logic
class SignUpController {
  // Instance of the SignUpService class to interact with the sign-up functionality
  final SignUpService signUpService = SignUpService();

  // Asynchronous method to initiate the sign-up process
  Future<void> signUp(String email, String password, String firstName,
      String lastName, BuildContext context) async {
    // Delegating sign-up logic to the SignUpService class
    await signUpService.signUp(email, password, firstName, lastName, context);
  }

  // Method to display error messages to the user
  void showError(BuildContext context, String message) {
    signUpService.showError(context, message);
  }
}
