import 'package:expenseapp/addexpensepage.dart';
import 'package:expenseapp/loginpage.dart';
import 'package:expenseapp/myhomepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart';

Future<void> loadKey() async {
  final prefs = await SharedPreferences.getInstance();
  jwtkey = prefs.getString('key') ?? '';
  username = prefs.getString('username') ?? '';
}

void main() async {
  await loadKey();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/addexpense': (context) => AddExpensePage(
              typeController: TextEditingController(),
              amountController: TextEditingController(),
            ),
      },
    );
  }
}
