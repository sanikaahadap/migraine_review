import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:neurooooo/onboarding/animated_page.dart';
import 'package:neurooooo/user_home/nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Validate extends StatelessWidget {
  const Validate({super.key});

  Future<bool> _isAdmin(String uid) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDoc.exists) {
      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      return data['admin_role'] ?? false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String uid = snapshot.data!.uid;
            return FutureBuilder<bool>(
              future: _isAdmin(uid),
              builder: (context, adminSnapshot) {
                if (adminSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const CustomBottomNavigationBar();
                }
              },
            );
          } else {
            return const AnimatedPage();
          }
        },
      ),
    );
  }
}
