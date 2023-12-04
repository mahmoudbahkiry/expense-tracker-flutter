// Importing necessary packages and files
import 'package:expense_tracker_project/controller/master_dialog_controller.dart';
import 'package:flutter/material.dart';

// Define a StatefulWidget for the MasterDialogView
class MasterDialogView extends StatefulWidget {
  // Constructor for the MasterDialogView widget
  const MasterDialogView({super.key});

  // Override createState method to create an instance of _MasterDialogViewState
  @override
  State<MasterDialogView> createState() => _MasterDialogViewState();
}

// Define the state for the MasterDialogView
class _MasterDialogViewState extends State<MasterDialogView> {
  // Create an instance of MasterDialogController to handle the logic
  final MasterDialogController _controller = MasterDialogController();

  // Override the build method to construct the UI
  @override
  Widget build(BuildContext context) {
    // Delegate the building of the UI to the MasterDialogController
    return _controller.build(context);
  }
}
