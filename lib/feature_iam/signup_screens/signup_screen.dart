import 'package:ayni_flutter_app/feature_iam/login_screens/login_screen.dart';
import 'package:ayni_flutter_app/feature_iam/signup_screens/create_account_screen.dart';

import 'package:flutter/material.dart';



class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ayni.png', height: 100),
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
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text('Create account'),
               style: ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
    foregroundColor: Colors.black, // Utiliza backgroundColor en lugar de primary
  ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
    
    foregroundColor: Colors.black,)
            ),
          ],
        ),
      ),
    );
  }
}