
import 'package:expense_tracker_project/ModelBar.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class ChartBar extends StatelessWidget {
  final List<ModelBar> data;

  ChartBar({required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<ModelBar, String>> series = [
      charts.Series(
        id: "developers",
        data: data,
        domainFn: (ModelBar series, _) => series.year.toString(),
        measureFn: (ModelBar series, _) => series.developers,
        colorFn: (ModelBar series, _) => series.barColor
      )
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(25),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              Text(
                "Yearly Expense Overview",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }

}