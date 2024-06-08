import 'package:flutter/material.dart';
import 'package:neurooooo/admin_home/admin_home.dart';
import 'package:neurooooo/login/login_signup_page.dart'; // Import the AdminHomePage

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  AdminLoginPageState createState() => AdminLoginPageState();
}

class AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = "bindumenon@gmail.com"; // Hard-coded email
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x80B2EBF2),
        title: const Text('Admin Login'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginSignupPage()),
            );
          },
        ),
      ),
      body: Container(
        color: const Color(0x80B2EBF2),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Admin Login',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF16666B),
                ),
              ),
              const SizedBox(height: 16.0),
              // email field
              TextField(
                decoration:  InputDecoration(
                  labelText: _emailController.text,
                ),
                enabled: false, // Makes the TextField read-only
              ),
              const SizedBox(height: 16.0),
              // Password field
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Basic authentication
                  if (
                      _passwordController.text == 'bindu') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AdminHomePage()),
                    );
                  } else {
                    // Show error message if credentials are incorrect
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Incorrect password.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16666B),
                  fixedSize: const Size(170.0, 45.0),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 17.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
