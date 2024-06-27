import 'package:ayni_flutter_app/feature_iam/signup_screens/signup_screen.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignupScreen()),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/ayni.png', height: 300),
              SizedBox(height: 20),
              
            ],
          ),
        ),
      ),
    );
  }
}