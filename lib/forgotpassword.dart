import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class forgotpasspg extends StatefulWidget {
  const forgotpasspg({super.key});

  @override
  State<forgotpasspg> createState() => _forgotpasspgState();
}

class _forgotpasspgState extends State<forgotpasspg> {
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
            return AlertDialog(
              content: Text("Password resent link sent successfully"),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter your e-mail ID'),
            SizedBox(
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
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 170.0,
              height: 45.0,
              child: MaterialButton(
                onPressed: passwordReset,
                child: Text(
                  'Reset Password',
                  style: TextStyle(color: Colors.white),
                ),
                color: const Color(0xFF16666B),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12.0), // Adjust the value as needed
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
