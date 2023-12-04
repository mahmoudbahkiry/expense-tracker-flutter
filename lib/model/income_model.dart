// Importing the necessary package for Firebase authentication.
import 'package:firebase_auth/firebase_auth.dart';

// Defining a class for the IncomeModel.
class IncomeModel {
  // Default value for the dropdown menu.
  String dropdownValue = 'Salary';

  // Variables to store the user ID and a list of income items.
  late String uid;
  late List<String> items;

  // Constructor for the IncomeModel class.
  IncomeModel() {
    // Retrieving the current user's UID from Firebase authentication or setting an empty string if not available.
    uid = FirebaseAuth.instance.currentUser?.uid ?? '';

    // Initializing the list of income items with predefined options.
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
