import 'dart:developer';
import 'dart:convert';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neurooooo/login/login.dart';
import 'package:neurooooo/models/user.dart';
import 'package:neurooooo/onboarding/userinfopage.dart';
import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  bool _isButtonPressed = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  DateTime? _selectedDate; // Nullable DateTime

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF16666B),
              onPrimary: Colors.white,
              surface: Color(0xFFE6E6E6), // Use a very light tone of #16666B
              onSurface: Colors.black, // Adjust text color if needed
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text =
            DateFormat('yyyy-MM-dd').format(_selectedDate!); // Formatting date
      });
    }
  }

  String? _validateBirthDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your date of birth';
    }
    try {
      DateFormat('yyyy-MM-dd').parse(value);
    } catch (e) {
      return 'Please enter a valid date in the format yyyy-MM-dd';
    }
    // Additional validation: Check if the selected date is in the past
    if (_selectedDate == null || _selectedDate!.isAfter(DateTime.now())) {
      return 'Please select a valid date in the past';
    }
    return null;
  }

  void createAccount() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String cPassword = _confirmPasswordController.text.trim();

    if (email == "" || password == "" || cPassword == "") {
      log("Please fill all the details!");
    } else if (password != cPassword) {
      log("Passwords do not match!");
    } else {
      String hashedPassword = hashPassword(password);

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          log("User created successfully");
          saveUser(); // Add this log
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UserInfoPage()));
        }
      } on FirebaseAuthException catch (ex) {
        log("FirebaseAuthException: ${ex.code}"); // Add this log
      } catch (e) {
        log("Error: $e"); // Add this log
      }
    }
  }

  String generateUniqueCode() {
    String code = generateRandomCode();
    bool codeExists = codeExistsInDatabase(code);

    while (codeExists) {
      code = generateRandomCode();
      codeExists = codeExistsInDatabase(code);
    }

    return code;
  }

  String generateRandomCode() {
    math.Random random = math.Random();
    // Generate a random 6-digit number
    int code = random.nextInt(900000) + 100000;
    return code.toString();
  }

  bool codeExistsInDatabase(String code) {
    bool exists = false;
    FirebaseFirestore.instance
        .collection('users')
        .where('patient_id', isEqualTo: code)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        exists = true; // Code exists in database
      }
    }).catchError((error) {
      log('Error checking code existence: $error');
    });
    return exists;
  }

  Future<void> saveUser() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String dob = _dobController.text.trim();
    String phone = _phoneController.text.trim();

    if (name != "" && email != "" && phone != "" && dob != "") {
      String patientId =
          generateUniqueCode(); // Generate unique 6-digit patient ID
      // Map<String, dynamic> userData = {
      //   "name": name,
      //   "email": email,
      //   "phone": phone,
      //   "dob": dob,
      //   "patient_id": patientId // Add patient ID to user data
      // };
      ModelUser user = ModelUser(
          uid: FirebaseAuth.instance.currentUser!.uid,
          name: name,
          email: email,
          phone: phone,
          dob: dob,
          patient_id: patientId);
      try {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(user.toJson());
        log("User created!");
      } catch (err) {
        log(err.toString());
      }
    } else {
      log("Please fill all the fields!");
    }
  }

  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
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
                  // Logo image
                  Image.asset(
                    'assets/images/logo.png',
                    height: MediaQuery.of(context).size.height * 0.15,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20.0),
                  // Name field
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color(0x80B2EBF2),
                      contentPadding:
                          EdgeInsets.fromLTRB(12.0, 15.0, 12.0, 15.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  // Email field
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color(0x80B2EBF2),
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
                  // Phone number field
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color(0x80B2EBF2),
                      contentPadding:
                          EdgeInsets.fromLTRB(12.0, 15.0, 12.0, 15.0),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return 'Enter a valid 10-digit phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  // Date of Birth field
                  TextFormField(
                    controller: _dobController,
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color(0x80B2EBF2),
                      contentPadding:
                          EdgeInsets.fromLTRB(12.0, 15.0, 12.0, 15.0),
                    ),
                    keyboardType: TextInputType.datetime,
                    onTap: () {
                      _selectDate(context);
                    },
                    readOnly: true,
                    validator: _validateBirthDate,
                  ),
                  const SizedBox(height: 16.0),
                  // Password field
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color(0x80B2EBF2),
                      contentPadding:
                          EdgeInsets.fromLTRB(12.0, 15.0, 12.0, 15.0),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  // Confirm Password field
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color(0x80B2EBF2),
                      contentPadding:
                          EdgeInsets.fromLTRB(12.0, 15.0, 12.0, 15.0),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      } else if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12.0),
                  // Sign Up button
                  InkWell(
                    onTap: () {
                      _onSignUpButtonPressed();
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
                          'Sign Up',
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
                  const SizedBox(height: 1.0),
                  // Already have an account? Login text
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                            color: Colors.grey[700]), // Dark gray color
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to login page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Color(0xFF16666B)), // Color #16666B
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSignUpButtonPressed() {
    if (_formKey.currentState!.validate()) {
      // Perform sign up logic here using form field controllers
      createAccount();
      saveUser();
    }
  }
}
