import 'package:expense_tracker_project/controller/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  final SplashScreenController _controller = SplashScreenController();

  @override
  void initState() {
    super.initState();
    _controller.initSplashScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("images/blakk-logo.jpg"),
              width: 300,
            ),
            SizedBox(height: 50),
            SpinKitFadingFour(
              color: Colors.green,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
