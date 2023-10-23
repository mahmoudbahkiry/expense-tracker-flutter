import 'package:expense_tracker_app/category_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropdownValue = "Not yet written";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Pro"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showExpenseDialog();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }

  void showExpenseDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return const CategoryDropDownButton();
            },
          ),
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          devtools.log(dropdownValue.toString());
          dropdownValue = value;
          devtools.log(dropdownValue.toString());
        });
      }
    });
  }
}
