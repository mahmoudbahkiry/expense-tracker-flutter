import 'package:expense_tracker_project/views/landing_page_view.dart';
import 'package:flutter/material.dart';

// Controller class for handling the splash screen logic
class SplashScreenController {
  // Method to initialize the splash screen
  void initSplashScreen(BuildContext context) {
    // Delay the navigation to the landing page by 3 seconds
    Future.delayed(const Duration(seconds: 3)).then((value) {
      // Replace the current screen with the LandingPageView using a custom page route
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          // Define the page to be displayed
          pageBuilder: (_, __, ___) => const LandingPageView(),
          // Set the transition duration to 500 milliseconds
          transitionDuration: const Duration(milliseconds: 500),
          // Define the transition effect using a fade transition
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        ),
      );
    });
  }
}
