import 'package:expense_tracker_project/income_expence_dropdown_menu.dart';
import 'package:expense_tracker_project/views/forget_pass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  String dropdownValue = "Not yet written";
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    const Icon(
      Icons.home,
      size: 150,
    ),
    const Icon(
      Icons.bar_chart,
      size: 150,
    ),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(child: _pages.elementAt(_selectedIndex)),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showIncomeExpenseDialog();
          },
          backgroundColor: const Color.fromARGB(255, 22, 182, 158),
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 15,
          selectedIconTheme: const IconThemeData(
              color: Color.fromARGB(255, 22, 182, 158), size: 30),
          selectedItemColor: const Color.fromARGB(255, 22, 182, 158),
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

class ProfilePage extends StatelessWidget {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const ForgetPass(),
                    transitionDuration: const Duration(milliseconds: 300),
                    transitionsBuilder: (_, a, __, c) =>
                        FadeTransition(opacity: a, child: c),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 22, 182, 158),
              ),
              child: const Text('Change Password',
                  style: TextStyle(
                    letterSpacing: .6,
                    color: Colors.white,
                    fontSize: 17,
                  )),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _signOut();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 22, 182, 158),
              ),
              child: const Text('Sign Out',
                  style: TextStyle(
                    letterSpacing: .6,
                    color: Colors.white,
                    fontSize: 17,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
