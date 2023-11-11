import 'package:expense_tracker_app/income_expence_dropdown_menu.dart';
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Expense Pro"),
          backgroundColor: Colors.green,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showIncomeExpenseDialog();
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void showIncomeExpenseDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return const IncomeExpenseDropdownMenu();
            },
          ),
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          dropdownValue = value;
          devtools.log(dropdownValue.toString());
        });
      }
    });
  }
}
