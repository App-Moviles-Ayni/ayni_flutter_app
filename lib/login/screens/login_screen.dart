import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password', suffixIcon: Icon(Icons.visibility)),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Log In'),
              style: ElevatedButton.styleFrom(primary: Colors.green),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Forgot your password?'),
            ),
          ],
        ),
      ),
    );
  }
}