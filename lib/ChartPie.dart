import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyPieChart extends StatefulWidget {
  @override
  _MyPieChartState createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChart> {
  Map<String, double> dataMap = {};
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    GetInfo();
  }

  Future<void> GetInfo() async {
    try {
      final firestore = FirebaseFirestore.instance;

      QuerySnapshot querySnapshot = await firestore.collection('Expense Pro').get();
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      List<Map<String, dynamic>> data = [];
      documents.forEach((doc) {
        Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
        if (docData.containsKey('type') && docData.containsKey('amount')) {
          data.add(docData);
        }
      });

      _data = data;
      convertData();
    } catch (e) {
      print('An error occurred: $e');
    }
  }

void convertData() {
  Map<String, double> tempMap = {};
  for (var item in _data) {
    if (item['type'] is String && item['amount'] is String) {
      double amount = double.tryParse(item['amount']) ?? 0.0;
      if (tempMap.containsKey(item['type'])) {
        // Checking if the value is not null
        tempMap[item['type']] = (tempMap[item['type']] ?? 0) + amount;
      } else {
        tempMap[item['type']] = amount;
      }
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
        SizedBox(height: 50), // Add a SizedBox widget at the top
        if (dataMap.isNotEmpty)
          PieChart(
            dataMap: dataMap,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 50,
            chartRadius: MediaQuery.of(context).size.width / 2.9,
            colorList: colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 30,
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