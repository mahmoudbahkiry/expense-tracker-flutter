import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:cloud_firestore/cloud_firestore.dart';

class IncomeDialog extends StatefulWidget {
  const IncomeDialog({Key? key}) : super(key: key);

  @override
  State<IncomeDialog> createState() => _IncomeDialogState();
}

class _IncomeDialogState extends State<IncomeDialog> {
  // first value that will appear before selecting an item from the dropdown button
  String dropdownvalue = 'Salary';
  String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

  // List of items in the dropdown button
  var items = [
    'Salary',
    'Freelance',
    'Business',
    'Investment',
    'Rental',
    'Side Hustles',
    'Retirement',
    'Bonuses',
    'Others'
  ];

  late final TextEditingController _descriptionIncome;
  late final TextEditingController _amountIncome;
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    _descriptionIncome = TextEditingController();
    _amountIncome = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _descriptionIncome.dispose();
    _amountIncome.dispose();
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
              'type': dropdownvalue,
              'amount': _amountIncome.text,
              'description': _descriptionIncome.text,
              'userID': uid,
            };
            db
                .collection(
                  "Expense Pro",
                )
                .add(income)
                .then((DocumentReference doc) => devtools
                    .log('Document added with ID: ${doc.id}'.toString()));
            Navigator.pop(context, dropdownvalue);
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
