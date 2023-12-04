import 'package:expense_tracker_project/model/home_page_model.dart';
import 'package:expense_tracker_project/views/forget_pass.dart';
import 'package:expense_tracker_project/views/master_dialog_view.dart';
import 'package:flutter/material.dart';

// Controller class for the home page
class HomePageController {
  // Model for the home page
  late HomePageModel _model;

  // Constructor initializing the model
  HomePageController() {
    _model = HomePageModel();
  }

  // Build method for constructing the home page UI
  Widget build(BuildContext context) {
    // Using WillPopScope to prevent accidental back navigation
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // Centered widget displaying the selected page
        body: Center(child: _model.pages.elementAt(_model.selectedIndex)),
        // Bottom navigation bar for switching between pages
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 15,
          selectedIconTheme: const IconThemeData(
              color: Color.fromARGB(255, 22, 182, 158), size: 30),
          selectedItemColor: const Color.fromARGB(255, 22, 182, 158),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          // Navigation bar items for Home and Profile
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          // Current index and tap handler for navigation bar
          currentIndex: _model.selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  // Callback method for handling tap on the navigation bar items
  void _onItemTapped(int index) {
    _model.selectedIndex = index;
  }

  // Method for showing a custom alert dialog
  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // Content of the alert dialog using a stateful builder
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return const MasterDialogView();
            },
          ),
        );
      },
    );
  }

  // Method for navigating to the Forget Password screen
  void navigateToForgetPassword(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const ForgetPass(),
        transitionDuration: const Duration(milliseconds: 300),
        // Fade transition for a smoother effect
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ),
    );
  }
}
