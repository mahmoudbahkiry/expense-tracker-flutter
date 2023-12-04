// home_page_view.dart

import 'package:expense_tracker_project/controller/home_page_controller.dart';
import 'package:expense_tracker_project/model/home_page_model.dart';
import 'package:expense_tracker_project/views/Login_view.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late HomePageController _controller;

  @override
  void initState() {
    _controller = HomePageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.build(context);
  }
}

class PageProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 22, 182, 158),
                  Color.fromARGB(255, 22, 182, 158),
                ],
              ),
            ),
          ),
          Center(
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                width: 300.0,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16.0),
                    const Text(
                      'Expense Pro',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text('Profile management'),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        HomePageController().navigateToForgetPassword(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 22, 182, 158),
                      ),
                      child: const Text('Change Password',
                          style: TextStyle(
                            letterSpacing: .6,
                            color: Colors.white,
                            fontSize: 17,
                          )),
                    ),
                    const SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        HomePageModel().signOut();
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const LoginScreen(),
                            transitionDuration:
                                const Duration(milliseconds: 300),
                            transitionsBuilder: (_, a, __, c) =>
                                FadeTransition(opacity: a, child: c),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 22, 182, 158),
                      ),
                      child: const Text('Sign Out',
                          style: TextStyle(
                            letterSpacing: .6,
                            color: Colors.white,
                            fontSize: 17,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
