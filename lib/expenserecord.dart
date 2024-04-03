class Expense {
  int type;
  double amount;

  Expense({required this.type, required this.amount});
  Expense.fromObj(dynamic obj)
      : type = obj[2],
        amount = obj[3];
}
