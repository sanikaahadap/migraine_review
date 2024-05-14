import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:neurooooo/onboarding/animated_page.dart';
import 'package:neurooooo/user_home/home.dart';
import 'package:neurooooo/login/login.dart';
import 'package:neurooooo/user_home/nav_bar.dart';

class Validate extends StatelessWidget {
  const Validate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const CustomBottomNavigationBar();
          } else {
            return const AnimatedPage();
          }
        },
      ),
    );
  }
}
