
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_project/income_expence_dropdown_menu.dart';
import 'package:expense_tracker_project/views/forget_pass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_project/views/ChartPie.dart';

// Creating a StatefulWidget for the home page
class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

// Defining the state of the StatefulWidget
class _PageHomeState extends State<PageHome> {
  List<Map<String, dynamic>> _data = [];
  String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

    @override
  void initState() {
    super.initState();
    fetchData();
  }

 // Asynchronous function to fetch data from Firestore
Future<void> fetchData() async {
  try {
    final firestore = FirebaseFirestore.instance;

      // Listening for changes in the Firestore collection
    firestore.collection('Expense Pro').where('userID', isEqualTo: uid).snapshots().listen((querySnapshot) {
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      List<Map<String, dynamic>> data = [];
      documents.forEach((doc) {
        Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
        // Checking if the document has the required fields 
        if (docData.containsKey('type') && docData.containsKey('amount') && docData.containsKey('description') && docData.containsKey('expenseIncomeType')) {
          docData['id'] = doc.id; 
          data.add(docData);
        }
      });

        // Updating the state of the list
      setState(() {
        _data = data;
      });
    });
  } catch (e) {
    print('An error occurred: $e');
  }
}


  // Building the widget and scaffold for transaction list
@override
Widget build(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: Stack(
      children: <Widget>[
        Container(),
        Column(
          children: <Widget>[
            Expanded(child: MyPieChart()),
            Expanded(
              child: ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('${_data[index]['type']}'),
                            content: Text('Amount: \$${_data[index]['amount']} \nDescription: ${_data[index]['description']} \nType: ${_data[index]['expenseIncomeType']}'),
                            actions: <Widget>[
                              TextButton(
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.red, 
                                ),
                              ),
                                onPressed: () {
                                  FirebaseFirestore.instance.collection('Expense Pro').doc(_data[index]['id']).delete(); 
                                  Navigator.of(context).pop();
                                },
                                ),
                                TextButton(
                                child: Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              
                            ],
                          );
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                      children: <Widget>[
                        Text('${_data[index]['type']} \$${_data[index]['amount']}'),
                        Icon(
                          _data[index]['expenseIncomeType'] == 'Income' ? Icons.arrow_upward : Icons.arrow_downward,
                          color: _data[index]['expenseIncomeType'] == 'Income' ? Colors.green : Colors.red,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 22, 182, 158),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        Align(
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
          ),
        ),
      ],
    ),
  );
}
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


class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  User? _user;
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    PageHome(),
    const Icon(
      Icons.bar_chart,
      size: 150,
    ),
    PageProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    _user = FirebaseAuth.instance.currentUser;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: _user != null
                ? Text('Signed in as ${_user!.email}', style: TextStyle(fontSize: 12),)
                : Container(),
          ),
        ),
        body: Center(child: _pages.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 15,
          selectedIconTheme: const IconThemeData(
            color: Color.fromARGB(255, 22, 182, 158),
            size: 30,
          ),
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
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/flower.png'), 
              fit: BoxFit.cover,
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