
import 'package:expense_tracker_project/views/home_page.dart';
import 'package:expense_tracker_project/views/splash_screen_view.dart';
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
          if (snapshot.hasData) {
            return const HomePage2();
          } else {
            return const SplashScreenView();
          }
        },
      ),
    );
  }
}
