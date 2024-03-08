import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:neurooooo/animated_page.dart';
import 'package:neurooooo/home.dart';
import 'package:neurooooo/login.dart';

class validate extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return AnimatedPage();
          }
        },
      ),
    );
  }
}
