import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'global.dart';

class AddExpensePage extends StatefulWidget {
  static const url = 'http://127.0.0.1:5000/add_expense';
  const AddExpensePage({
    super.key,
    required this.typeController,
    required this.amountController,
  });
  final typeController;
  final amountController;

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  var hintText = '';

  Future<Response> addExpense(int type, int amount) async {
    try {
      final response = await http.post(
        Uri.parse(AddExpensePage.url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtkey',
        },
        body: jsonEncode({
          'type': '$type',
          'amount': '$amount',
        }),
      );
      return response;
    } catch (e) {
      print(e.runtimeType);
      return Response('{"error": "${e.runtimeType}"}', 500);
    }
  }

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
              Text(hintText),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: widget.typeController,
                decoration: InputDecoration(
                  hintText: 'Type',
                  hintStyle: const TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: widget.amountController,
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
                  int? type = int.tryParse(widget.typeController.text);
                  int? amount = int.tryParse(widget.amountController.text);

                  if (type == null || amount == null) {
                    setState(() {
                      hintText = 'Please enter a valid number';
                    });
                    return;
                  }

                  hintText = '';
                  addExpense(type, amount).then((resp) {
                    if (resp.statusCode == 200) {
                      Navigator.pop(context);
                    } else if (resp.statusCode == 401) {
                      hintText = 'Unauthorized, try logging in again';
                    } else if (resp.statusCode == 403) {
                      hintText = 'Invalid token, try logging in again';
                    } else {
                      var decoded = jsonDecode(resp.body);
                      setState(() {
                        hintText =
                            'Error code ${resp.statusCode}: ${decoded['error']}';
                      });
                    }
                  });
                },
                child: const Text('Add Expense'),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
