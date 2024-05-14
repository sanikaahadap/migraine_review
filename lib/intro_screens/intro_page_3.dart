import 'package:flutter/material.dart';
import 'package:neurooooo/login/login_signup_page.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
              'assets/intro_images/intro_3.png',
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Personalized Reminders',
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(22, 102, 107, 1.0),
                  fontSize: 30.0,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Get custom reminders to stay on course with your goals and lifestyle. They match your needs and symptom checks.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.grey[700],
                  fontSize: 12.0,

                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginSignupPage()),
                );
              },
              child: const Text(
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
