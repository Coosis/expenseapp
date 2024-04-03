import 'package:flutter/material.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({
    super.key,
    required this.typeController,
    required this.amountController,
  });
  final typeController;
  final amountController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: typeController,
                decoration: InputDecoration(
                  hintText: 'Type',
                  hintStyle: const TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  hintText: 'Amount',
                  hintStyle: const TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  // print('Add expense');
                },
                child: const Text('Add Expense'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
