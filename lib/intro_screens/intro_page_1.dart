import 'package:flutter/material.dart';
import 'package:neurooooo/login_signup_page.dart'; // Import the login/signup page

class IntroPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/intro_images/intro_1.png',
              width: 250,
              height: 250,
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Track And Assess',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(22, 102, 107, 1.0),
                  fontSize: 30.0,
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Understand your migraine patterns by regularly checking in. This helps tailor your care for better results.',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.grey[700],
                  fontSize: 15.0,
                ),
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginSignupPage()), // Navigate to login_signup_page.dart
                );
              },
              child: Text(
                'Login/Sign Up',
                style: TextStyle(
                  color: Color.fromRGBO(22, 102, 107, 1.0),
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
