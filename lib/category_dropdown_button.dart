import 'package:flutter/material.dart';

class CategoryDropDownButton extends StatefulWidget {
  const CategoryDropDownButton({Key? key}) : super(key: key);

  @override
  State<CategoryDropDownButton> createState() => _CategoryDropDownButtonState();
}

class _CategoryDropDownButtonState extends State<CategoryDropDownButton> {
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
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, dropdownvalue);
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
