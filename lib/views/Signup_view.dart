import 'package:expense_tracker_app/views/Login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// SignUpService class handles user registration and authentication
class SignUpService {
  // Checks if the user's email is verified
  Future<bool> isEmailVerified(User? user) async {
    if (user == null) return false;
    await user.reload();
    user = FirebaseAuth.instance.currentUser;
    return user?.emailVerified ?? false;
  }

  // Signs up a new user with provided credentials
  Future<void> signUp(
    String email, String password, String firstName, String lastName, BuildContext context) async {
    try {
      // Creates a new user account
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Sends email verification to the new user
      User? user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();

      // Shows a message about the verification email
      showError(context, "A verification email has been sent. Please check your email.");

      // Checks if the email is verified before allowing sign-in
      if (!await isEmailVerified(user)) {
        showError(context, "Please verify your email before signing in.");
        return;
      }

      // Shows a success message
      showError(context, "A verification email has been sent. Please check your email.");
    } on FirebaseAuthException catch (e) {
      // Handles authentication exceptions
      handleAuthException(context, e);
    } catch (e) {
      // Handles unexpected errors
      showError(context, "An unexpected error occurred. Please try again later.");
    }
  }

  // Displays an error message using a SnackBar
  void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // Handles authentication exceptions and displays appropriate error messages
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

// SignUp class is the main widget for the sign-up screen
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Controllers for input fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  // SignUpService instance for handling user registration
  final SignUpService signUpService = SignUpService();

  @override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  // Handles the sign-up process
  void signUp() async {
    // Checks if all required fields are filled
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _firstNameController.text.trim().isEmpty ||
        _lastNameController.text.trim().isEmpty) {
      signUpService.showError(context, "Please fill in all the required fields");
      return;
    }

    // Attempts to sign up the user
    await signUpService.signUp(
      _emailController.text,
      _passwordController.text,
      _firstNameController.text,
      _lastNameController.text,
      context,
    );
  }

  // Widget for reusable text fields
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
              // Validates email format
              if (isEmailField) {
                if (value == null ||
                    !value.contains('@') ||
                    !value.contains('.')) {
                  return 'Please enter a valid email address';
                }
              }
              // Validates password length
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
                // Reusable text field for email
                buildTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email, color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  isEmailField: true,
                ),
                // Reusable text field for first name
                buildTextField(
                  controller: _firstNameController,
                  hintText: 'First name',
                  prefixIcon: const Icon(Icons.person, color: Colors.black),
                  keyboardType: TextInputType.text,
                ),
                // Reusable text field for last name
                buildTextField(
                  controller: _lastNameController,
                  hintText: 'Last name',
                  prefixIcon: const Icon(Icons.person, color: Colors.black),
                  keyboardType: TextInputType.text,
                ),
                // Reusable text field for password
                buildTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock, color: Colors.black),
                  obscureText: true,
                  isPassword: true,
                ),
                // Sign-up button
                buildSignUpButton(),
                // Sign-in link
                buildSignInText(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for the sign-up button
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

  // Widget for the sign-in link
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
