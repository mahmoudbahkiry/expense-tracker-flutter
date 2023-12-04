import 'package:firebase_auth/firebase_auth.dart';

class IncomeModel {
  String dropdownValue = 'Salary';
  late String uid;
  late List<String> items;
  DateTime today = DateTime.now();

  IncomeModel() {
    uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    items = [
      'Salary',
      'Freelance',
      'Business',
      'Investment',
      'Rental',
      'Side Hustles',
      'Retirement',
      'Bonuses',
      'Others'
    ];
  }
}
