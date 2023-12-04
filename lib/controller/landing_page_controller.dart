// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:expense_tracker_project/views/signup_view.dart';

// This class represents the controller for the landing page, responsible for building and handling navigation.

class LandingPageController {
  // Build method returns the widget tree for the landing page.
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Welcome to Expense Pro!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.all(16)),
              const Text(
                'Your road to financial responsibility starts here ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the SignUp page when the 'Get Started' button is pressed.
                  navigateToSignUp(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 22, 182, 158),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    letterSpacing: .6,
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Method to navigate to the SignUp page with a fade transition.
  void navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SignUp(),
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ),
    );
  }
}
