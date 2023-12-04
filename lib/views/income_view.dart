// Import necessary packages
import 'package:expense_tracker_project/controller/income_controller.dart';
import 'package:flutter/material.dart';

// Define a widget class for the IncomeView
class IncomeView extends StatefulWidget {
  const IncomeView({super.key});

  // Override the createState method to create an instance of the _IncomeViewState
  @override
  State<IncomeView> createState() => _IncomeViewState();
}

// Define the state class for the IncomeView
class _IncomeViewState extends State<IncomeView> {
  // Declare a private instance of the IncomeController
  late IncomeController _controller;

  // Override the initState method to initialize the state
  @override
  void initState() {
    // Create an instance of IncomeController when the widget is initialized
    _controller = IncomeController();
    super.initState();
  }

  // Override the dispose method to clean up resources when the widget is disposed
  @override
  void dispose() {
    // Dispose of the IncomeController to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }

  // Override the build method to define the widget's UI
  @override
  Widget build(BuildContext context) {
    // Delegate the build operation to the IncomeController, which returns a widget
    return _controller.build(context);
  }
}
