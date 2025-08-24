// LoginPage.dart
import 'package:flutter/material.dart';
import 'package:heartdesaseapp/homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    Future<void> loginUser() async {
      final response = await http.post(
        Uri.parse('http://100.119.177.30/heart_health_mobil_php/login.php'),
        body: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      final data = jsonDecode(response.body);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'])),
      );

      if (data['status'] == 'success') {
        print(data);
        // user_id'yi API yanıtından alıyoruz
        final userId = data['userId'];

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(userId: userId),
          ),
        );
      }
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D0EB5), Color(0xFF4059F1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.login, size: 48, color: Colors.pinkAccent),
                  const SizedBox(height: 24),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "Email",
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.pinkAccent, Colors.orangeAccent],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pinkAccent.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: loginUser,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                    child: const Text(
                      "Don’t have an account? Register",
                      style: TextStyle(
                        color: Color(0xFF6D0EB5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
