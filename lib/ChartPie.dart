import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:expense_tracker_app/TransactionHistory.dart';

class MyPieChart extends StatefulWidget {
  @override
  _MyPieChartState createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChart> {
  List<Map<String, dynamic>> Newdata = [] ;
  Map<String, double> dataMap = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    convertData();
  }

  void convertData() {
    Map<String, double> tempMap = {};
    for (var item in Newdata) {
      if (item['type'] is String && item['amount'] is num) {
        tempMap[item['type']] = item['amount'].toDouble();
      }
    }
    setState(() {
      dataMap = tempMap;
    });
  }

  List<Color> colorList = [
    Colors.blue,
    const Color.fromARGB(255, 27, 105, 29),
    Colors.yellow,
    Colors.red,
    Color.fromARGB(255, 36, 190, 190),
    const Color.fromARGB(255, 120, 54, 244),
    const Color.fromARGB(255, 244, 139, 54),
    Color.fromARGB(255, 162, 212, 53),
    Color.fromARGB(255, 244, 54, 111),
    Color.fromARGB(255, 172, 161, 160),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PieChart(
            dataMap: dataMap,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 50,
            chartRadius: MediaQuery.of(context).size.width / 2.9,
            colorList: colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 30,
            centerText: "Expenses",
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
          ),
        ],
      ),
    );
  }
}
