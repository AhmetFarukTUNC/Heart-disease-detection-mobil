import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Register Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(), // Başlangıç sayfası
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}
