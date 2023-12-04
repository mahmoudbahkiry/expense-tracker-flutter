import 'package:expense_tracker_project/model/authentication_service.dart';
import 'package:flutter/material.dart';

// Controller class responsible for handling login-related logic
class LoginController {
  // Instance of the AuthenticationService class to manage authentication operations
  final AuthenticationService authService = AuthenticationService();

  // Asynchronous function to initiate the sign-in process
  // Takes email, password, and the BuildContext for navigation and UI interaction
  Future<void> signIn(
      String email, String password, BuildContext context) async {
    // Delegating sign-in functionality to the AuthenticationService
    await authService.signIn(email, password, context);
  }

  // Method to display error messages to the user
  // Takes the BuildContext for UI interaction and the error message to be displayed
  void showError(BuildContext context, String message) {
    // Delegating error display functionality to the AuthenticationService
    authService.showError(context, message);
  }
}
