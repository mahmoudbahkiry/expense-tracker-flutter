import 'package:expense_tracker_project/controller/expense_controller.dart';
import 'package:flutter/material.dart';

// The ExpenseView class represents the UI for displaying and managing expenses.
class ExpenseView extends StatefulWidget {
  const ExpenseView({super.key});

  @override
  State<ExpenseView> createState() => _ExpenseViewState();
}

// The _ExpenseViewState class is the corresponding state class for ExpenseView.
class _ExpenseViewState extends State<ExpenseView> {
  late ExpenseController _controller;

  @override
  void initState() {
    // Initialize the ExpenseController when the widget is first created.
    _controller = ExpenseController();
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the ExpenseController when the widget is removed from the widget tree.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build and return the UI using the ExpenseController.
    return _controller.build(context);
  }
}
