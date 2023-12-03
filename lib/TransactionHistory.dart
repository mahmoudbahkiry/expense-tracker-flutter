import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchData extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FetchData> {
  List<Map<String, dynamic>> _data = [];
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    GetInfo();
  }

  Future<void> GetInfo() async {
    try {
      final firestore = FirebaseFirestore.instance;

      QuerySnapshot querySnapshot = await firestore.collection('Expense Pro').get();
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      List<Map<String, dynamic>> data = [];
      documents.forEach((doc) {
        Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
        if (docData.containsKey('type') && docData.containsKey('amount') && docData.containsKey('description') && docData.containsKey('expenseIncomeType')) {
          data.add(docData);
        }
      });

      setState(() {
        _data = data;
      });
    } catch (e) {
      print('An error occurred: $e');
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
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
              backgroundColor: Color.fromARGB(255, 22, 182, 158),  
              foregroundColor: Colors.white, 
            ),
          );
        },
      ),
    ),
  );
}
}