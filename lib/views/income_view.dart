import 'package:expense_tracker_project/controller/income_controller.dart';
import 'package:flutter/material.dart';

class IncomeView extends StatefulWidget {
  const IncomeView({super.key});

  @override
  State<IncomeView> createState() => _IncomeViewState();
}

class _IncomeViewState extends State<IncomeView> {
  late IncomeController _controller;

  @override
  void initState() {
    _controller = IncomeController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.build(context);
  }
}
