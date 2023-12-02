
import 'package:expense_tracker_project/income_expence_dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  String dropdownValue = "Not yet written";
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Icon(
      Icons.home,
      size: 150,
    ),
    Icon(
      Icons.bar_chart,
      size: 150,
    ),
    Icon(
      Icons.person,
      size: 150,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(child: _pages.elementAt(_selectedIndex)),
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
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 15,
          selectedIconTheme: const IconThemeData(color: Colors.green, size: 30),
          selectedItemColor: Colors.green,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Chart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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