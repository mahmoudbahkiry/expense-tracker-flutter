import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Line Model code
class TooltipBehavior {} var _tooltipBehavior;

class _ModelLine extends State<ModelLine> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            child: SfCartesianChart(

              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Line Graph'),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: _tooltipBehavior,

              series: <LineSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                    dataSource:  <SalesData>[
                      SalesData('Jan', 35),
                      SalesData('Feb', 28),
                      SalesData('Mar', 34),
                      SalesData('Apr', 32),
                      SalesData('May', 40)
                    ],
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales,
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true)
                )
              ]
            )
          )
        )
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class ModelLine extends StatefulWidget {
  ModelLine({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ModelLine createState() => _ModelLine();
}

