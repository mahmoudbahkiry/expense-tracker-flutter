import 'package:expense_tracker_project/model/master_dialog_model.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_project/views/income_view.dart';
import 'package:expense_tracker_project/views/expense_view.dart';
import 'dart:developer' as devtools show log;

/// Controller class for the master dialog that handles user interactions
/// and manages the state of the master dialog.
class MasterDialogController {
  final MasterDialogModel _model = MasterDialogModel();

  /// Builds the UI for the master dialog.
  Widget build(BuildContext context) {
    // Available options for the dropdown menu
    var items = ['Expense', 'Income'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Dropdown menu for selecting 'Expense' or 'Income'
        Row(
          children: [
            const Text('Type: '),
            DropdownButton(
              value: _model.dropdownValue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items.map((String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Update the selected value in the model
                _model.setDropdownValue(newValue!);
              },
            )
          ],
        ),
        // Ok button to confirm selection and trigger dialog display
        TextButton(
          onPressed: () {
            Navigator.pop(context, _model.dropdownValue);

            if (_model.dropdownValue == 'Expense') {
              _showExpenseDialog(context);
            } else if (_model.dropdownValue == 'Income') {
              _showIncomeDialog(context);
            }
          },
          child: const Text(
            "Ok",
            style: TextStyle(color: Color.fromARGB(255, 22, 182, 158)),
          ),
        ),
        // Cancel button to dismiss the dialog
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            devtools.log(_model.dropdownValue.toString());
          },
          child: const Text(
            "Cancel",
            style: TextStyle(color: Color.fromARGB(255, 22, 182, 158)),
          ),
        ),
      ],
    );
  }

  /// Displays the expense dialog.
  void _showExpenseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return const ExpenseView();
            },
          ),
        );
      },
    );
  }

  /// Displays the income dialog.
  void _showIncomeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return const IncomeView();
            },
          ),
        );
      },
    );
  }
}
