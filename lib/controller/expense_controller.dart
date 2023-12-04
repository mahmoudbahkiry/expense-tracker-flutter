import 'package:expense_tracker_project/model/expense_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class ExpenseController {
  late ExpenseModel _model;
  late TextEditingController _descriptionExpense;
  late TextEditingController _amountExpense;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ExpenseController() {
    _model = ExpenseModel();
    _descriptionExpense = TextEditingController();
    _amountExpense = TextEditingController();
  }

  void dispose() {
    _descriptionExpense.dispose();
    _amountExpense.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
        TextField(
          controller: _amountExpense,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: "Amount (EGP)"),
        ),
        TextField(
          controller: _descriptionExpense,
          enableSuggestions: true,
          autocorrect: true,
          decoration: const InputDecoration(hintText: "Description"),
        ),
        TextButton(
          onPressed: () {
            final expense = {
              'expenseIncomeType': 'Expense',
              'type': _model.dropdownValue,
              'amount': _amountExpense.text,
              'description': _descriptionExpense.text,
              'userID': _model.uid,
            };
            _db.collection("Expense Pro").add(expense).then(
                  (DocumentReference doc) => devtools.log(
                      'DocumentSnapshot added with ID: ${doc.id}'.toString()),
                );

            Navigator.pop(context, _model.dropdownValue);
          },
          child: const Text(
            "Add",
            style: TextStyle(color: Color.fromARGB(255, 22, 182, 158)),
          ),
        ),
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
