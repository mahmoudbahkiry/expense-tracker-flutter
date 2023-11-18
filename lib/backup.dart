import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchData extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FetchData> {
  String _data = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    GetInfo();
  }

  Future<void> GetInfo() async {
  try {
    // Your existing code...
  } catch (e) {
    print('An error occurred: $e');
  }

    final firestore = FirebaseFirestore.instance;

    // Get data from Firestore
    QuerySnapshot querySnapshot = await firestore.collection('Expense Pro').get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    // Prepare data for writing to file
    String data = '';
    documents.forEach((doc) {
      data += doc.data().toString() + '\n';
    });

    // Get local path
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;

    // Create a reference to the file location
    final file = File('$path/data.txt');

    // Write data to the file
    await file.writeAsString(data);

    print('Data from Firestore: $data');

    // Update the state to reflect the data
    setState(() {
      _data = data;
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_data),
        ],
      ),
    ),
  );
}

}