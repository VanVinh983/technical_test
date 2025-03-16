import 'package:flutter/material.dart';
import 'views/login_screen.dart';
import 'services/authentication_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationService _authService = AuthenticationService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(authService: _authService),
    );
  }
}
