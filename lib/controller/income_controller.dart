import 'package:expense_tracker_project/model/income_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

// Controller class responsible for managing the UI logic and interactions
class IncomeController {
  // Private member variables
  late IncomeModel _model; // Instance of the IncomeModel class
  late TextEditingController
      _descriptionIncome; // Controller for description input field
  late TextEditingController _amountIncome; // Controller for amount input field
  final FirebaseFirestore _db = FirebaseFirestore
      .instance; // Firestore instance for database interactions

  // Constructor for initializing the controller and its member variables
  IncomeController() {
    _model = IncomeModel(); // Initializing the IncomeModel
    _descriptionIncome =
        TextEditingController(); // Initializing the description controller
    _amountIncome =
        TextEditingController(); // Initializing the amount controller
  }

  // Method to dispose of the controllers when they are no longer needed
  void dispose() {
    _descriptionIncome.dispose();
    _amountIncome.dispose();
  }

  // Method to build the UI elements for income entry form
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Dropdown for selecting income type
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
                _model.dropdownValue = newValue!;
                devtools.log(_model.dropdownValue.toString());
              },
            )
          ],
        ),
        // Text field for entering income amount
        TextField(
          controller: _amountIncome,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: "Amount (EGP)"),
        ),
        // Text field for entering income description
        TextField(
          controller: _descriptionIncome,
          enableSuggestions: true,
          autocorrect: true,
          decoration: const InputDecoration(hintText: "Description"),
        ),
        // Button for adding income entry to the database
        TextButton(
          onPressed: () {
            // Creating a map representing the income entry
            final income = {
              'expenseIncomeType': 'Income',
              'type': _model.dropdownValue,
              'amount': _amountIncome.text,
              'description': _descriptionIncome.text,
              'userID': _model.uid,
            };

            // Adding the income entry to the Firestore database
            _db.collection("Expense Pro").add(income).then(
                  (DocumentReference doc) => devtools
                      .log('Document added with ID: ${doc.id}'.toString()),
                );

            // Closing the current screen and returning the selected income type
            Navigator.pop(context, _model.dropdownValue);

            // Logging the entered amount and description for debugging
            devtools.log(_amountIncome.text.toString());
            devtools.log(_descriptionIncome.text.toString());
          },
          child: const Text(
            "Add",
            style: TextStyle(color: Color.fromARGB(255, 22, 182, 158)),
          ),
        ),
        // Button for canceling the income entry and closing the form
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
