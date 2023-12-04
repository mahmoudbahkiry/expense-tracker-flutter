import 'package:expense_tracker_project/views/home_page_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePageModel {
  String dropdownValue = "Not yet written";
  int selectedIndex = 0;
  final List<Widget> pages = <Widget>[const PageHome(), const PageProfile()];

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
