import 'package:flutter/material.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create an account'),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Email address'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password', suffixIcon: Icon(Icons.visibility)),
              obscureText: true,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Select your role'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Create account'),
              style: ElevatedButton.styleFrom(primary: Colors.green),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Already have an account?'),
            ),
          ],
        ),
      ),
    );
  }
}