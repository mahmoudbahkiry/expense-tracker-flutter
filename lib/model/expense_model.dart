class ExpenseModel {
  String dropdownValue = 'Housing';
  late String uid;
  late List<String> items;

  ExpenseModel() {
    uid = ''; // Initialize uid or get it from FirebaseAuth
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
