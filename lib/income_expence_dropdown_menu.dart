
import 'package:expense_tracker_project/expense_dialog.dart';
import 'package:expense_tracker_project/income_dialog.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class IncomeExpenseDropdownMenu extends StatefulWidget {
  const IncomeExpenseDropdownMenu({Key? key}) : super(key: key);

  @override
  State<IncomeExpenseDropdownMenu> createState() =>
      _IncomeExpenseDropdownMenuState();
}

class _IncomeExpenseDropdownMenuState extends State<IncomeExpenseDropdownMenu> {
  // first value that will appear before selecting an item from the dropdown button
  String dropdownvalue = 'Expense';
  String dropdownState = 'Not yet written';

  // List of items in the dropdown button
  var items = [
    'Expense',
    'Income',
  ];
  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'Expense';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Text('Type: '),
            DropdownButton(
              // Initial Value
              value: dropdownvalue,

              // A down arror icon beside the dropdown button
              icon: const Icon(Icons.keyboard_arrow_down),

              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // The select option will appear on top of the dropdown menu button after selected
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            )
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, dropdownvalue);

            if (dropdownvalue == 'Expense') {
              showExpenseDialog();
            } else if (dropdownvalue == 'Income') {
              showIncomeDialog();
            }
          },
          child: const Text("Ok"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            devtools.log(dropdownValue.toString());
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  void showExpenseDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return const ExpenseDialog();
            },
          ),
        );
      },
    );
  }

  void showIncomeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return const IncomeDialog();
            },
          ),
        );
      },
    );
  }
}