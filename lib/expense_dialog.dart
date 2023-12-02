import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseDialog extends StatefulWidget {
  const ExpenseDialog({Key? key}) : super(key: key);

  @override
  State<ExpenseDialog> createState() => _ExpenseDialogState();
}

class _ExpenseDialogState extends State<ExpenseDialog> {
  // first value that will appear before selecting an item from the dropdown button
  String dropdownvalue = 'Housing';
  String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

  // List of items in the dropdown button
  var items = [
    'Housing',
    'Transportation',
    'Food',
    'Utilities',
    'Insurance',
    'Medical & Healthcare',
    'Saving/investing',
    'Personal Spending',
    'Entertainment',
    'Others'
  ];

  late final TextEditingController _descriptionExpense;
  late final TextEditingController _amountExpense;
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    _descriptionExpense = TextEditingController();
    _amountExpense = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _descriptionExpense.dispose();
    _amountExpense.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  devtools.log(dropdownvalue.toString());
                });
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
              'type': dropdownvalue,
              'amount': _amountExpense.text,
              'description': _descriptionExpense.text,
              'userID': uid,
            };
            db
                .collection(
                  "Expense Pro",
                )
                .add(expense)
                .then((DocumentReference doc) => devtools.log(
                    'DocumentSnapshot added with ID: ${doc.id}'.toString()));

            Navigator.pop(context, dropdownvalue);
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
