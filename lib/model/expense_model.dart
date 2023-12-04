import 'package:firebase_auth/firebase_auth.dart';

class ExpenseModel {
  String dropdownValue = 'Housing';
  late String uid;
  late List<String> items;
  DateTime today = DateTime.now();

  ExpenseModel() {
    uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    items = [
      'Housing',
      'Transportation',
      'Food',
      'Utilities',
      'Insurance',
      'Medical & Healthcare',
      'Saving/investing',
      'Personal Spending',
      'Entertainment',
      'Others'
    ];
  }
}
