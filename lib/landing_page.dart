import 'package:expense_tracker_app/home_page.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome Screen'),
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Welcome to Expense Pro!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.all(16)),
              const Text(
                'Your road to financial responsibility starts here ',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const HomePage(),
                      transitionDuration: const Duration(milliseconds: 300),
                      transitionsBuilder: (_, a, __, c) =>
                          FadeTransition(opacity: a, child: c),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );

    // return MaterialApp(
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Welcome Screen'),
    //       backgroundColor: Colors.green,
    //     ),
    //     body: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           const Text(
    //             'Welcome to Expense Pro!',
    //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //             textAlign: TextAlign.center,
    //           ),
    //           Padding(padding: EdgeInsets.all(16)),
    //           const Text(
    //             'The road to financial responsibility starts here ',
    //             style: TextStyle(fontSize: 16),
    //             textAlign: TextAlign.center,
    //           ),
    //           const SizedBox(height: 50),
    //           ElevatedButton(
    //             onPressed: () {
    //               Navigator.push(
    //                 context,
    //                 PageRouteBuilder(
    //                   pageBuilder: (_, __, ___) => const HomePage(),
    //                   transitionDuration: const Duration(milliseconds: 300),
    //                   transitionsBuilder: (_, a, __, c) =>
    //                       FadeTransition(opacity: a, child: c),
    //                 ),
    //               );
    //             },
    //             style: ElevatedButton.styleFrom(
    //               backgroundColor: Colors.green,
    //             ),
    //             child: const Text('Get Started'),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
