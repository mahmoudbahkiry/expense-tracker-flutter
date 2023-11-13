import 'package:expense_tracker_app/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove debug banner
      debugShowCheckedModeBanner: false,
      // Make the Dashboard the first screen to appear
      home: DashBoard(), 

    );
  }
}