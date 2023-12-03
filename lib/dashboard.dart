
import 'package:expense_tracker_project/ChartPie.dart';
import 'package:expense_tracker_project/FirestoreService.dart';
import 'package:flutter/material.dart';





class DashBoard extends StatelessWidget {

  // Scaffold for dashboard

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            Expanded(child: MyPieChart()),
            Expanded(child: FetchData(),),
          ],
        ),
      ),
    );
  }
}




 




