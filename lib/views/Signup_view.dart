// signup_screen.dart
// Import the Login view
import 'package:expense_tracker_project/controller/signup_controller.dart';
import 'package:expense_tracker_project/views/Login_view.dart';
import 'package:flutter/material.dart'; // Import Flutter material library

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final SignUpController signUpController = SignUpController(); // Create an instance of the SignUpController

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void signUp() async {
    // Check if all required fields are not empty
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _firstNameController.text.trim().isEmpty ||
        _lastNameController.text.trim().isEmpty) {
      signUpController.showError(context, "Please fill in all the required fields");
      return;
    }

    // Attempt to sign up the user using the SignUpController
    await signUpController.signUp(
      _emailController.text,
      _passwordController.text,
      _firstNameController.text,
      _lastNameController.text,
      context,
    );
  }

  Widget buildTextField({
    TextEditingController? controller,
    String hintText = '',
    Icon? prefixIcon,
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
          color: Color.fromARGB(255, 0, 0, 0).withOpacity(.2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: controller,
            enableSuggestions: false,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(color: Color.fromARGB(212, 0, 0, 0)),
              prefixIcon: prefixIcon,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              // Validate email format if it's an email field
              if (isEmailField) {
                if (value == null ||
                    !value.contains('@') ||
                    !value.contains('.')) {
                  return 'Please enter a valid email address';
                }
              }
              // Validate password length if it's a password field
              if (isPassword) {
                if (value == null || value.length < 6) {
                  return 'Minimum required characters: 6';
                }
              }
              return null; // Return null if the input is valid
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(246, 255, 255, 255),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/john-new.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/undraw_my_app_re_gxtj.png',
                  height: 130,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Welcome to ExpensePro :)  ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                // Reusable method to build email input field
                buildTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email, color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  isEmailField: true,
                ),
                // Reusable method to build first name input field
                buildTextField(
                  controller: _firstNameController,
                  hintText: 'First name',
                  prefixIcon: const Icon(Icons.person, color: Colors.black),
                  keyboardType: TextInputType.text,
                ),
                // Reusable method to build last name input field
                buildTextField(
                  controller: _lastNameController,
                  hintText: 'Last name',
                  prefixIcon: const Icon(Icons.person, color: Colors.black),
                  keyboardType: TextInputType.text,
                ),
                // Reusable method to build password input field
                buildTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock, color: Colors.black),
                  obscureText: true,
                  isPassword: true,
                ),
                // Reusable method to build sign-up button
                buildSignUpButton(),
                // Reusable method to build sign-in link
                buildSignInText(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable method to build sign-up button
  Widget buildSignUpButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 22, 182, 158),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: GestureDetector(
              onTap: signUp, // Call the signUp function when pressed
              child: const Text(
                'Sign up',
                style: TextStyle(
                  letterSpacing: .6,
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Reusable method to build sign-in link
  Widget buildSignInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Already have an account? ",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigate to the LoginScreen when "Sign In" is clicked
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: const Text(
              ' Sign In',
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