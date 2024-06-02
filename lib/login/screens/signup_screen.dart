import 'package:flutter/material.dart';
import 'create_account_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 100),
            SizedBox(height: 20),
            Text('Stay on top of your finance with us.', textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(
              'We are your new financial Advisors to recommend the best products for you.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateAccountScreen()),
                );
              },
              child: Text('Create account'),
              style: ElevatedButton.styleFrom(primary: Colors.green),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}