import 'package:expense_tracker_project/controller/landing_page_controller.dart';
import 'package:flutter/material.dart';

class LandingPageView extends StatefulWidget {
  const LandingPageView({super.key});

  @override
  State<LandingPageView> createState() => _LandingPageViewState();
}

class _LandingPageViewState extends State<LandingPageView> {
  final LandingPageController _controller = LandingPageController();

  @override
  Widget build(BuildContext context) {
    return _controller.build(context);
  }
}
