import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  Future<void> login() async {
    const String url = 'http://127.0.0.1:5000/login';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username_controller.text,
        'password': password_controller.text,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final String tmp = data['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('key', tmp);
      setState(() {
        jwtkey = tmp;
        username = Jwt.parseJwt(jwtkey)['user_name'];
      });
      await prefs.setString('username', username);
    } else {
      final data = json.decode(response.body);
      print(data['error']);
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('key');
    await prefs.remove('username');
    setState(() {
      jwtkey = '';
      username = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (jwtkey != '') {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: Text(
                'Welcome, $username!',
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: logout,
              child: const Text('Logout'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: username_controller,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: password_controller,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
