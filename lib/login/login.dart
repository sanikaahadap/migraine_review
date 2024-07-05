import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neurooooo/admin_home/admin_home.dart';
import 'package:neurooooo/login/forgot_password.dart';
import 'package:neurooooo/onboarding/features.dart';
import 'package:neurooooo/user_home/nav_bar.dart';
// import 'package:crypto/crypto.dart';
// import 'dart:convert';
import 'dart:developer';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isButtonPressed = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showInvalidCredentials = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // Your app bar content goes here
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20.0),
                  // Logo image
                  Image.asset(
                    'assets/images/logo.png',
                    height: MediaQuery.of(context).size.height * 0.15,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 30.0),
                  // Email field
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color(
                          0x80B2EBF2), // Half lighter tint of the background color
                      contentPadding:
                      EdgeInsets.fromLTRB(12.0, 15.0, 12.0, 15.0),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  // Password field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: const Color(
                          0x80B2EBF2), // Half lighter tint of the background color
                      contentPadding:
                      const EdgeInsets.fromLTRB(12.0, 15.0, 12.0, 15.0),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a valid password';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      } else if (!RegExp(
                          r'(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+{}|:;<>,.?/~`]).{8,}')
                          .hasMatch(value)) {
                        return 'Password must contain at least one letter, one number, and one special character';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40.0),
                  // Login button
                  InkWell(
                    onTap: () {
                      _onLoginButtonPressed();
                    },
                    onTapDown: (_) {
                      setState(() {
                        _isButtonPressed = true;
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        _isButtonPressed = false;
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        _isButtonPressed = false;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 170.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        color: _isButtonPressed
                            ? Colors.white
                            : const Color(0xFF16666B),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 17.0,
                            color: _isButtonPressed
                                ? const Color(0xFF16666B)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_showInvalidCredentials)
                    const Text(
                      'Invalid credentials',
                      style: TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 20.0),
                  // Forgot Password text link
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Color(0xFF16666B)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Features(),
                        ),
                      );
                    },
                    child: const Text(
                      'Create an account',
                      style: TextStyle(color: Color(0xFF16666B)),
                    ),
                  ),
                  const SizedBox(height: 150),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Features(),
                        ),
                      );
                    },
                    child: const Text(
                      'Go back to tour',
                      style: TextStyle(color: Color(0xFF16666B)),
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

  void _onLoginButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Authenticate with Firebase
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Get user document from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        // Check if user has admin_role set to true
        if (userDoc.exists && userDoc['admin_role'] == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminHomePage()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CustomBottomNavigationBar()),
          );
        }
      } catch (e) {
        setState(() {
          _showInvalidCredentials = true;
        });
        log('Error: $e');
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
