import 'dart:convert';

import 'package:expenseapp/expenserecord.dart';
import 'package:expenseapp/expenseview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'global.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({
    super.key,
    required this.switchpage,
  });
  final Function(int) switchpage;

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  static const url = 'http://127.0.0.1:5000/get_expenses';
  List<Expense> expenses = [];

  Future<void> fetchExpenses() async {
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $jwtkey',
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['expenses'];
      for (final item in data) {
        setState(() {
          expenses.add(Expense.fromObj(item));
        });
      }
    } else if (response.statusCode == 401) {
      jwtkey = '';
      username = '';
      widget.switchpage(1);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ExpenseView(
            expense: expenses[index],
          );
        },
        itemCount: expenses.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addexpense');
          // print('Add expense');
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple[200],
      ),
    );
  }
}
