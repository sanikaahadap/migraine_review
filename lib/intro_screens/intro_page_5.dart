import 'package:flutter/material.dart';
import 'package:neurooooo/login_signup_page.dart';

class IntroPage5 extends StatelessWidget {
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
              'assets/intro_images/intro_5.png',
              width: 250,
              height: 250,
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'FAQs',
                textAlign: TextAlign.center,
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
                'Your personal ally, ready to understand and assist in managing your migraine journey, 24/7.',
                textAlign: TextAlign.center,
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
                  MaterialPageRoute(builder: (context) => LoginSignupPage()),
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
