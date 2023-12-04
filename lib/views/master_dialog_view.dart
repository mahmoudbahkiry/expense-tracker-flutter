import 'package:expense_tracker_project/controller/master_dialog_controller.dart';
import 'package:flutter/material.dart';

class MasterDialogView extends StatefulWidget {
  const MasterDialogView({super.key});

  @override
  State<MasterDialogView> createState() => _MasterDialogViewState();
}

class _MasterDialogViewState extends State<MasterDialogView> {
  final MasterDialogController _controller = MasterDialogController();

  @override
  Widget build(BuildContext context) {
    return _controller.build(context);
  }
}
