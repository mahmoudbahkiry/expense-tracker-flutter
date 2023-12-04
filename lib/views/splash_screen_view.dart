// Importing necessary packages and files
import 'package:expense_tracker_project/controller/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Defining the SplashScreenView class as a StatefulWidget
class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

// Defining the state for the SplashScreenView
class _SplashScreenViewState extends State<SplashScreenView> {
  // Creating an instance of the SplashScreenController
  final SplashScreenController _controller = SplashScreenController();

  // Overriding the initState method to perform initialization tasks
  @override
  void initState() {
    super.initState();

    // Initializing the splash screen controller with the current context
    _controller.initSplashScreen(context);
  }

  // Overriding the build method to create the widget tree
  @override
  Widget build(BuildContext context) {
    // Returning a Scaffold with a Column containing the logo and loading spinner
    return const Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Displaying the app logo
            Image(
              image: AssetImage("images/blakk-logo.jpg"),
              width: 300,
            ),
            SizedBox(height: 50),
            // Displaying a fading four-point spinner with a green color
            SpinKitFadingFour(
              color: Colors.green,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
