// Importing the necessary package for Firebase Authentication
import 'package:firebase_auth/firebase_auth.dart';

// Class representing the ExpenseModel
class ExpenseModel {
  // Dropdown value representing the default category, initialized to 'Housing'
  String dropdownValue = 'Housing';

  // User ID (UID) associated with the current authenticated user
  late String uid;

  // List of predefined expense categories
  late List<String> items;

  // Constructor for the ExpenseModel class
  ExpenseModel() {
    // Retrieving the UID of the current authenticated user from Firebase Authentication
    uid = FirebaseAuth.instance.currentUser?.uid ?? '';

    // Initializing the list of predefined expense categories
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
