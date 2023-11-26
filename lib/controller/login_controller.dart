// login_controller.dart
import 'package:expense_tracker_app/model/authentication_service.dart';
import 'package:flutter/material.dart';


class LoginController {
  final AuthenticationService authService = AuthenticationService();

  Future<void> signIn(String email, String password, BuildContext context) async {
    await authService.signIn(email, password, context);
  }

  void showError(BuildContext context, String message) {
    authService.showError(context, message);
  }
}
