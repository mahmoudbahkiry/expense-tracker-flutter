import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  
  final List<String> dummyData = List<String>.generate(100, (i) => 'Item $i');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Container(
          height: 375.0,
          child: ListView.builder(
            itemCount: dummyData.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(dummyData[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}