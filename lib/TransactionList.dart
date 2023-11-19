import 'package:flutter/material.dart';
import 'package:expense_tracker_app/TransactionHistory.dart';

class TransactionList extends StatelessWidget {
  final List<String> data;

  TransactionList({required this.data});

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
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}