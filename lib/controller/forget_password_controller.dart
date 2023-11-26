import 'package:expense_tracker_app/model/forgetPass_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ForgetPasswordController {
  final TextEditingController emailController = TextEditingController();

  Future<void> execute(BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      String errorMessage = '';
      bool isVerified = await AuthModel.isEmailVerified();

      if (!isVerified) {
        errorMessage = 'Verify email before you can reset the password';
        showError(context, errorMessage);
      } else {
        await sendResetEmail(context);
      }
    } catch (e) {
      showError(context, 'An unexpected error occurred. Please try again later.');
    }
  }

  Future<void> sendResetEmail(BuildContext context) async {
    try {
      final email = emailController.text.trim();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent successfully.')),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = (e.code == 'invalid-email') ? 'Invalid email' : 'Incorrect email';

      Navigator.of(context).pop();
      showError(context, errorMessage);
    }
  }

  void showError(BuildContext context, String message) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
