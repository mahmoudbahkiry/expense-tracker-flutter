import 'package:expense_tracker_app/ChartBar.dart';
import 'package:expense_tracker_app/ModelBar.dart';
import 'package:expense_tracker_app/ChartPie.dart';
import 'package:expense_tracker_app/ModelLine.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:expense_tracker_app/TransactionList.dart';



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

  // Scaffold for dashboard



@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TransactionList(),
    );
  }
}

// Scaffold for Pie Chart
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



 




