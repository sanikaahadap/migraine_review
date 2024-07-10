import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Password resent link sent successfully"),
            );
          });
    } on FirebaseAuthException catch (e) {
      log(e as String);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Enter your e-mail ID'),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(
                    0x80B2EBF2), // Half lighter tint of the background color
                contentPadding: EdgeInsets.fromLTRB(12.0, 15.0, 12.0, 15.0),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return 'Enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 170.0,
              height: 45.0,
              child: MaterialButton(
                onPressed: passwordReset,
                color: const Color(0xFF16666B),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12.0), // Adjust the value as needed
                ),
                child: const Text(
                  'Reset Password',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.redAccent),
                ),
                child: const Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      'Your password should be as follows',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '• Password length should be 8 or greater',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    Text(
                      '• Consist of lowercase letters and numbers',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    Text(
                      '• Contains at least 1 number',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ],
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}