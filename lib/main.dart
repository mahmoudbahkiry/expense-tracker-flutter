import 'package:expense_tracker_app/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/TransactionHistory.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';






void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

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