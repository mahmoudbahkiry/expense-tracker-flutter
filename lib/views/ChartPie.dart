import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Creating a StatefulWidget for the pie chart
class MyPieChart extends StatefulWidget {
  @override
  _MyPieChartState createState() => _MyPieChartState();
}

// Defining the state of the StatefulWidget
class _MyPieChartState extends State<MyPieChart> {
  Map<String, double> dataMap = {};
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    GetInfo();
  }

  // Function to fetch data from Firestore
void GetInfo() {
  try {
    final firestore = FirebaseFirestore.instance;
    String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

      // Listening for changes in the Firestore collection
    firestore.collection('Expense Pro').where('userID', isEqualTo: uid).snapshots().listen((querySnapshot) {
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      List<Map<String, dynamic>> data = [];
      documents.forEach((doc) {
        Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
        if (docData.containsKey('type') && docData.containsKey('amount') && docData['expenseIncomeType'] == 'Expense') {
          data.add(docData);
        }
      });

      // Updating the data list
      _data = data;
      convertData();
    });
  } catch (e) {
    print('An error occurred: $e');
  }
}

  // Converting the data for the pie chart
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

  // Building the widget and scaffold for the graph
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 25.0), 
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
          bottomLeft: Radius.circular(50.0),
          bottomRight: Radius.circular(50.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.green, Colors.blue], 
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50), 
              if (dataMap.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(left: 20.0), 
                  child: PieChart(
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
                ),
            ],
          ),
        ),
      ),
    ),
  );
}
}
