import 'package:expense_tracker_app/ChartBar.dart';
import 'package:expense_tracker_app/ModelBar.dart';
import 'package:expense_tracker_app/ChartPie.dart';
import 'package:expense_tracker_app/ModelLine.dart';
import 'package:expense_tracker_app/TransactionHistory.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:expense_tracker_app/TransactionList.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:expense_tracker_app/firebase_options.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';



class DashBoard extends StatelessWidget {

// Data for Bar Graph
  final List<ModelBar> data = [

    ModelBar(
      year: 2017,
      developers: 40000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    ModelBar( 
      year: 2018,
      developers: 5000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    ModelBar(
      year: 2019,
      developers: 40000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    ModelBar(
      year: 2020,
      developers: 35000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    ModelBar(
      year: 2021,
      developers: 45000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
  ];



// Non functioning dropdown button implementation for graphs
/*
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<rftDashBoard> {
  String dropdownValue = 'Pie Chart';

  void handleDropdownChange(String? newValue) {
    setState(() {
      dropdownValue = newValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          actions: <Widget>[
            MyDropDown(dropdownValue: dropdownValue, onChanged: handleDropdownChange),
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: MyBody(dropdownValue: dropdownValue),
      ),
    );
  }
}

class MyDropDown extends StatelessWidget {
  final String dropdownValue;
  final ValueChanged<String?> onChanged;

  MyDropDown({Key? key, required this.dropdownValue, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: onChanged,
      items: <String>['Pie Chart', 'Bar Graph', 'Line Graph']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class MyBody extends StatelessWidget {
  final String dropdownValue;

  MyBody({Key? key, required this.dropdownValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: dropdownValue == 'Pie Chart' ? MyPieChart() : dropdownValue == 'Bar Graph' ? ChartBar(data: [],) : MyPieChart(),
        ),
        Expanded(
          child: TransactionList(),
        ), 
      ],
    );
  }
}
*/

















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







// Scaffold for Transaction History
/*
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TransactionList(),
    );
  }
}
*/

// Scaffold for Pie Chart
/*
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MyPieChart(),
    );
  }
}
*/

// Data for line graph
/*    List<SalesData> _chartData = <SalesData>[
    SalesData('Jan', 35),
    SalesData('Feb', 28),
    SalesData('Mar', 34),
    SalesData('Apr', 32),
    SalesData('May', 40)
  ];

// Scaffold for line graph
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(text: 'Line Graph'),
            legend: Legend(isVisible: true),
            series: <LineSeries<SalesData, String>>[
              LineSeries<SalesData, String>(
                dataSource: _chartData,
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales,
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

// Scaffold for Bar Chart
/*@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ChartBar(
          data: data,
        )
      ),
    );
  }
*/



 




