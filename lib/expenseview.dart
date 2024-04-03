import 'package:expenseapp/expenserecord.dart';
import 'package:flutter/material.dart';

class ExpenseView extends StatelessWidget {
  final Expense expense;
  const ExpenseView({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 16),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              expense.type == 0 ? Icons.money_off : Icons.money,
              color: expense.type == 0 ? Colors.red : Colors.green,
            ),
            const SizedBox(width: 8),
            Text(
              expense.amount.toString(),
              style: TextStyle(
                color: expense.type == 0 ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
