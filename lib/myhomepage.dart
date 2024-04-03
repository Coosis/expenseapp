import 'package:expenseapp/loginpage.dart';
import 'package:expenseapp/expensepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'global.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final pages;
  int _selectedIndex = 1;

  void switchPage(int index) {
    if (index != 1 && jwtkey.isEmpty) {
      index = 1;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    pages = [
      ExpensePage(
        switchpage: (index) => switchPage(index),
      ),
      const LoginPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurple[200],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Expenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'User',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(0.5),
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index != 1 && jwtkey.isEmpty) {
            index = 1;
            return;
          }
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
