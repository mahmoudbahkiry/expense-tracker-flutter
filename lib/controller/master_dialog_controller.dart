import 'package:expense_tracker_project/model/master_dialog_model.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_project/views/income_view.dart';
import 'package:expense_tracker_project/views/expense_view.dart';
import 'dart:developer' as devtools show log;

class MasterDialogController {
  final MasterDialogModel _model = MasterDialogModel();

  Widget build(BuildContext context) {
    var items = ['Expense', 'Income'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Text('Type: '),
            DropdownButton(
              value: _model.dropdownValue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                _model.setDropdownValue(newValue!);
              },
            )
          ],
        ),
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
