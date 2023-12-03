
import 'package:expense_tracker_project/SplashScreen.dart';
import 'package:expense_tracker_project/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
  stream: FirebaseAuth.instance.authStateChanges(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      // Show a loading indicator or splash screen while checking authentication state.
      return SplashScreen();
    } else if (snapshot.hasData && snapshot.data!.emailVerified) {
      // User is signed in and email is verified.
      return const HomePage2();
    } else {
      // User is not signed in or email is not verified.
      return SplashScreen();
    }
  },
      ),
);

}
}