import 'package:flutter/material.dart';
import 'income_dialog.dart';
import 'dart:developer' as devtools show log;

class ExpenseDialog extends StatefulWidget {
  const ExpenseDialog({Key? key}) : super(key: key);

  @override
  State<ExpenseDialog> createState() => _ExpenseDialogState();
}

class _ExpenseDialogState extends State<ExpenseDialog> {
  // first value that will appear before selecting an item from the dropdown button
  String dropdownvalue = 'Housing';

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
            Navigator.pop(context, dropdownvalue);
            devtools.log(_amountExpense.text.toString());
            devtools.log(_descriptionExpense.text.toString());
          },
          child: const Text("Add"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
