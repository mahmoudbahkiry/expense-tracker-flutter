// signup_controller.dart
import 'package:expense_tracker_app/model/signup_service.dart';
import 'package:flutter/material.dart';


class SignUpController {
  final SignUpService signUpService = SignUpService();

  Future<void> signUp(
    String email, String password, String firstName, String lastName, BuildContext context) async {
    await signUpService.signUp(email, password, firstName, lastName, context);
  }

  void showError(BuildContext context, String message) {
    signUpService.showError(context, message);
  }
}
