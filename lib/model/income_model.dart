class IncomeModel {
  String dropdownValue = 'Salary';
  late String uid;
  late List<String> items;

  IncomeModel() {
    uid = ''; // Initialize uid or get it from FirebaseAuth
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
