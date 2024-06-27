import 'package:ayni_flutter_app/feature_iam/services/iam_service.dart';
import 'package:ayni_flutter_app/home_screens/screens/products_list_screen.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _login() async {
    final response = await _authService.signIn(
      _usernameController.text,
      _passwordController.text,
    );
    if (response.statusCode == 200) {
      // Inicio de sesión exitoso
      print('Inicio de sesión exitoso: ${response.body}');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductsListScreen()),
      );
    } else {
      // Error en el inicio de sesión
      print('Error en el inicio de sesión: ${response.body}');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductsListScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create a farmer account')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _usernameController, decoration: InputDecoration(labelText: 'Username')),
            TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: Text('Login'), style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.green), foregroundColor: WidgetStateProperty.all(Colors.black),
        ))],
        ),
      ),
    );
  }
}
