import 'package:expense_tracker_project/controller/login_controller.dart';
import 'package:expense_tracker_project/views/Signup_view.dart';
import 'package:flutter/material.dart'; // Import Flutter material library
import 'forget_pass.dart'; // Import the ForgetPass view

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginController loginController =
      LoginController(); // Create an instance of the LoginController

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _signIn() async {
    // Check if email and password are not empty
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      loginController.showError(
          context, "Please enter both an email and a password");
      return;
    }

    // Attempt to sign in with provided credentials using the login controller
    await loginController.signIn(
        emailController.text, passwordController.text, context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
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
                  Image.asset('images/undraw_Mobile_login_re_9ntv.png',
                      height: 140),
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Your money, your rules',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  // Reusable method to build email input field
                  buildInputField(
                    isEmailField: true,
                    controller: emailController,
                    hintText: 'Email',
                    icon: const Icon(Icons.email_outlined, color: Colors.black),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  // Reusable method to build password input field
                  buildInputField(
                    isPassword: true,
                    controller: passwordController,
                    hintText: 'Password',
                    icon: const Icon(Icons.lock_outline, color: Colors.black),
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  // Reusable method to build sign-in button
                  buildSignInButton(),
                  const SizedBox(height: 10),
                  // Reusable method to build sign-up link
                  buildSignUpText(context),
                  const SizedBox(height: 10),
                  // Reusable method to build forgot password link
                  ForgetPassText(context),
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        // Disable the back button
        return false;
      },
    );
  }

  // Reusable method to build input fields
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

  // Reusable method to build sign-in button
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

  // Reusable method to build sign-up link
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
              // Navigate to the SignUp screen when "Sign Up" is clicked
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUp()));
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

// Reusable method to build forgot password link
Widget ForgetPassText(BuildContext context) {
  return GestureDetector(
    onTap: () {
      // Navigate to the ForgetPass screen when "Forgot password" is clicked
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
