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
            const SizedBox(height: 20),
            const Text('Stay on top of your finance with us.', textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            const Text(
              'We are your new financial Advisors to recommend the best products for you.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.black,),
              child: const Text('Create account'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(    
                foregroundColor: Colors.black,),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}