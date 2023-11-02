import 'package:expense_tracker_app/ChartBar.dart';
import 'package:expense_tracker_app/ModelBar.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;



class DashBoard extends StatelessWidget {

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
      body: Center(
        child: ChartBar(
          data: data,
        )
      ),
    );
  }
}



