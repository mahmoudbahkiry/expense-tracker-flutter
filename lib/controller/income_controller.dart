import 'package:expense_tracker_project/model/income_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class IncomeController {
  late IncomeModel _model;
  late TextEditingController _descriptionIncome;
  late TextEditingController _amountIncome;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  IncomeController() {
    _model = IncomeModel();
    _descriptionIncome = TextEditingController();
    _amountIncome = TextEditingController();
  }

  void dispose() {
    _descriptionIncome.dispose();
    _amountIncome.dispose();
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
          controller: _amountIncome,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: "Amount (EGP)"),
        ),
        TextField(
          controller: _descriptionIncome,
          enableSuggestions: true,
          autocorrect: true,
          decoration: const InputDecoration(hintText: "Description"),
        ),
        TextButton(
          onPressed: () {
            final income = {
              'expenseIncomeType': 'Income',
              'type': _model.dropdownValue,
              'amount': _amountIncome.text,
              'description': _descriptionIncome.text,
              'userID': _model.uid,
            };
            _db.collection("Expense Pro").add(income).then(
                  (DocumentReference doc) => devtools
                      .log('Document added with ID: ${doc.id}'.toString()),
                );
            Navigator.pop(context, _model.dropdownValue);
            devtools.log(_amountIncome.text.toString());
            devtools.log(_descriptionIncome.text.toString());
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
