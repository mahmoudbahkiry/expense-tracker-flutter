import 'package:expense_tracker_project/views/home_page_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Define a class for the HomePageModel
class HomePageModel {
  // Initialize a default value for the dropdown
  String dropdownValue = "Not yet written";

  // Initialize the selected index for the bottom navigation bar
  int selectedIndex = 0;

  // Define a list of pages for the bottom navigation bar
  final List<Widget> pages = <Widget>[const PageHome(), const PageProfile()];

  // Asynchronous method to sign out the user
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
