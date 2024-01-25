import 'package:flutter/material.dart';
import 'package:neurooooo/login.dart';
import 'package:neurooooo/signup.dart';

class LoginSignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x80B2EBF2), // Set the background color for the AppBar
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: const Color(0x80B2EBF2),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(

            children: [
              const SizedBox(height: 70.0),
              // Logo image
              Image.asset(
                'assets/images/logo.png',
                height: MediaQuery.of(context).size.height * 0.22,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 16.0),

              // 'Welcome' text
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF16666B),
                ),
              ),
              const SizedBox(height: 16.0),

              // Login button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
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
              const SizedBox(height: 16.0),

              // Signup button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16666B),
                  fixedSize: const Size(170.0, 45.0),
                ),
                child: const Text(
                  'Signup',
                  style: TextStyle(fontSize: 17.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginSignupPage(),
  ));
}
