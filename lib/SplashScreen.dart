

import 'package:expense_tracker_project/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then((value) {
      // Navigator.of(context).push(
      //   CupertinoPageRoute(
      //     builder: (ctx) => const HomePage(),
      //   ),
      // );
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const LandingPage(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        ),
      );
    });
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
            SizedBox(
              height: 50,
            ),
            SpinKitFadingFour(
              color: Colors.green,
              size: 50.0,
            )
          ],
        ),
      ),
    );
  }
}