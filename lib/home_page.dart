// ignore_for_file: deprecated_member_use
import 'package:expense_tracker_project/income_expence_dropdown_menu.dart';
import 'package:expense_tracker_project/views/Login_view.dart';
import 'package:expense_tracker_project/views/forget_pass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    PageHome(),
    PageProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(child: _pages.elementAt(_selectedIndex)),
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
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }
}

class PageHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed: () {
                _showAlertDialog(context);
              },
              backgroundColor: const Color.fromARGB(255, 22, 182, 158),
              child: const Icon(Icons.add),
            ),
          )),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return const IncomeExpenseDropdownMenu();
            },
          ),
        );
      },
    );
  }
}

class PageProfile extends StatelessWidget {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 22, 182, 158),
                  Color.fromARGB(255, 22, 182, 158)
                ],
              ),
            ),
          ),
          Center(
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                width: 300.0,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16.0),
                    const Text(
                      'Expense Pro',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text('Profile management'),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const ForgetPass(),
                            transitionDuration:
                                const Duration(milliseconds: 300),
                            transitionsBuilder: (_, a, __, c) =>
                                FadeTransition(opacity: a, child: c),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 22, 182, 158),
                      ),
                      child: const Text('Change Password',
                          style: TextStyle(
                            letterSpacing: .6,
                            color: Colors.white,
                            fontSize: 17,
                          )),
                    ),
                    const SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        _signOut();
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const LoginScreen(),
                            transitionDuration:
                                const Duration(milliseconds: 300),
                            transitionsBuilder: (_, a, __, c) =>
                                FadeTransition(opacity: a, child: c),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 22, 182, 158),
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
            ),
          ),
        ],
      ),
    );
  }
}
