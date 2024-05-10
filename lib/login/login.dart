import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:neurooooo/features.dart';
import 'package:neurooooo/forgotpassword.dart';
import 'package:neurooooo/home.dart';
import 'package:neurooooo/nav_bar.dart';
import 'package:neurooooo/signup.dart';
import 'package:crypto/crypto.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _isButtonPressed = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showInvalidCredentials = false;

  void login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      log("Please fill all the fields!");
    } else {
      String hashedPassword = hashPassword(password);
      log(hashedPassword);
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredential.user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
                builder: (context) => CustomBottomNavigationBar()),
          );
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
        setState(() {
          _showInvalidCredentials = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // Your app bar content goes here
          ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
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
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color(
                          0x80B2EBF2), // Half lighter tint of the background color
                      contentPadding:
                          EdgeInsets.fromLTRB(12.0, 15.0, 12.0, 15.0),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a valid password';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      } else if (!RegExp(
                              r'(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+{}|:;<>,.?/~`]).{8,}')
                          .hasMatch(value)) {
                        String error = '';
                        if (!RegExp(r'(?=.*[0-9])').hasMatch(value)) {
                          error += 'At least one number required.\n';
                        }
                        if (!RegExp(r'(?=.*[!@#$%^&*()_+{}|:;<>,.?/~`])')
                            .hasMatch(value)) {
                          error += 'At least one special symbol required.\n';
                        }
                        return error.trim();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40.0),
                  // Login button without affecting email and password fields
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
                              builder: (context) => const Forgotpasspg()));
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
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
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
                        MaterialPageRoute(builder: (context) => const Features()),
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

  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  void _onLoginButtonPressed() {
    if (_formKey.currentState!.validate()) {
      // Perform login logic here using _emailController.text and _passwordController.text
      login();
    }
  }
}
