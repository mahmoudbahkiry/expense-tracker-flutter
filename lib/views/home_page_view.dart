import 'package:expense_tracker_project/controller/home_page_controller.dart';
import 'package:expense_tracker_project/model/home_page_model.dart';
import 'package:expense_tracker_project/views/Login_view.dart';
import 'package:flutter/material.dart';

// The main class representing the HomePageView widget.
class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

// The state class for HomePageView, managing the state and initialization.
class _HomePageViewState extends State<HomePageView> {
  late HomePageController _controller;

  @override
  void initState() {
    // Initialize the HomePageController when the state is created.
    _controller = HomePageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Delegate the build operation to the controller.
    return _controller.build(context);
  }
}

// A widget representing the main content for the home page.
class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Create an instance of the HomePageController.
    final HomePageController controller = HomePageController();

    return Scaffold(
      body: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: FloatingActionButton(
            onPressed: () {
              // Call a method from the controller to show an alert dialog.
              controller.showAlertDialog(context);
            },
            backgroundColor: const Color.fromARGB(255, 22, 182, 158),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

// A widget representing the profile page.
class PageProfile extends StatelessWidget {
  const PageProfile({super.key});

  @override
  Widget build(BuildContext context) {
    // Create instances of the controller and model.
    final HomePageController controller = HomePageController();
    final HomePageModel model = HomePageModel();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            // Apply a gradient background to the page.
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
                        // Navigate to the "Forget Password" screen.
                        controller.navigateToForgetPassword(context);
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
                      onPressed: () async {
                        // Sign out the user and navigate to the login screen.
                        await model.signOut();
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
