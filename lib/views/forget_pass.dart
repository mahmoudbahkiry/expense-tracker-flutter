import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// AuthOperation is an abstract class defining an authentication operation interface
abstract class AuthOperation {
  Future<void> execute(String email, BuildContext context);
}

// ForgetPasswordService class implements AuthOperation and handles password reset functionality
class ForgetPasswordService implements AuthOperation {
  final TextEditingController emailController = TextEditingController();

  @override
  Future<void> execute(String email, BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      String errorMessage = '';
      bool isVerified = await isEmailVerified();

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

  // Sends a password reset email
  Future<void> sendResetEmail(BuildContext context) async {
    try {
      final email = emailController.text.trim();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      Navigator.of(context).pop(); // Close the loading dialog

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent successfully.')),
      );

      // Optionally, you can navigate back to the previous screen or perform any other actions.
    } on FirebaseAuthException catch (e) {
      String errorMessage = (e.code == 'invalid-email') ? 'Invalid email' : 'Incorrect email';

      Navigator.of(context).pop(); // Close the loading dialog

      showError(context, errorMessage);
    }
  }

  // Checks if the user's email is verified
  Future<bool> isEmailVerified() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload(); // Reload user information from Firebase
    user = FirebaseAuth.instance.currentUser; // Get the updated user
    return user?.emailVerified ?? false; // Return whether email is verified or not
  }

  // Displays an error message using a SnackBar
  void showError(BuildContext context, String message) {
    Navigator.of(context).pop(); // Close the loading dialog
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

// ForgetPass is the main widget for the "Forgot Password" screen
class ForgetPass extends StatefulWidget {
  const ForgetPass({Key? key}) : super(key: key);

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  // Instance of ForgetPasswordService for handling password reset
  final ForgetPasswordService passwordService = ForgetPasswordService();

  @override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    passwordService.emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Forgot password? ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset('images/undraw_Forgot_password_re_hxwm.png', height: 200),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter the email address associated with your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'We will email you with a link to reset your password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w100,
                    color: Color.fromARGB(107, 105, 105, 105),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: passwordService.emailController,
                  decoration: const InputDecoration(
                    hintText: 'Type your email ..',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 22, 182, 158)),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  passwordService.execute(passwordService.emailController.text, context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color.fromARGB(75, 0, 255, 229)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text('Send'),
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}
