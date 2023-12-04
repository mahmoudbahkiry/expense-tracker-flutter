// Importing necessary dependencies for the LandingPageView class
import 'package:expense_tracker_project/controller/landing_page_controller.dart';
import 'package:flutter/material.dart';

// Defining the LandingPageView class, which is a StatefulWidget
class LandingPageView extends StatefulWidget {
  // Constructor for the LandingPageView class
  const LandingPageView({Key? key}) : super(key: key);

  // Overriding the createState method to create an instance of _LandingPageViewState
  @override
  State<LandingPageView> createState() => _LandingPageViewState();
}

// The private state class for the LandingPageView widget
class _LandingPageViewState extends State<LandingPageView> {
  // Creating an instance of LandingPageController to manage the state of the landing page
  final LandingPageController _controller = LandingPageController();

  // Overriding the build method to define the UI structure of the landing page
  @override
  Widget build(BuildContext context) {
    // Invoking the build method of the LandingPageController to build the UI
    return _controller.build(context);
  }
}
