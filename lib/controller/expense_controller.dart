import 'package:expense_tracker_project/model/expense_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

// ExpenseController class responsible for managing the UI and data flow
class ExpenseController {
  late ExpenseModel _model; // Model to manage data
  late TextEditingController
      _descriptionExpense; // Controller for description input
  late TextEditingController _amountExpense; // Controller for amount input
  final FirebaseFirestore _db = FirebaseFirestore
      .instance; // Firestore instance for database interactions

  // Constructor to initialize the controller and related objects
  ExpenseController() {
    _model = ExpenseModel(); // Initialize ExpenseModel
    _descriptionExpense =
        TextEditingController(); // Initialize description input controller
    _amountExpense =
        TextEditingController(); // Initialize amount input controller
  }

  // Dispose method to release resources when the controller is no longer needed
  void dispose() {
    _descriptionExpense.dispose(); // Dispose of description input controller
    _amountExpense.dispose(); // Dispose of amount input controller
  }

  // Method to build the UI for adding expenses
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Dropdown for selecting expense type
        Row(
          children: [
            const Text('Type: '),
            DropdownButton(
              value: _model.dropdownValue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: _model.items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                _model.dropdownValue =
                    newValue!; // Update selected dropdown value
                devtools.log(
                    _model.dropdownValue.toString()); // Log the selected value
              },
            )
          ],
        ),
        // Text field for entering the expense amount
        TextField(
          controller: _amountExpense,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: "Amount (EGP)"),
        ),
        // Text field for entering the expense description
        TextField(
          controller: _descriptionExpense,
          enableSuggestions: true,
          autocorrect: true,
          decoration: const InputDecoration(hintText: "Description"),
        ),
        // Button to add the expense to the database
        TextButton(
          onPressed: () {
            // Create a map representing the expense data
            final expense = {
              'expenseIncomeType': 'Expense',
              'type': _model.dropdownValue,
              'amount': _amountExpense.text,
              'description': _descriptionExpense.text,
              'userID': _model.uid,
            };
            // Add the expense data to the Firestore database
            _db.collection("Expense Pro").add(expense).then(
                  (DocumentReference doc) => devtools.log(
                      'DocumentSnapshot added with ID: ${doc.id}'.toString()),
                );

            // Close the current screen and pass the selected type back
            Navigator.pop(context, _model.dropdownValue);
          },
          child: const Text(
            "Add",
            style: TextStyle(color: Color.fromARGB(255, 22, 182, 158)),
          ),
        ),
        // Button to cancel and close the current screen
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Cancel",
            style: TextStyle(color: Color.fromARGB(255, 22, 182, 158)),
          ),
        ),
      ],
    );
  }
}
