import 'package:flutter/material.dart';
import 'package:neurooooo/user_home/home.dart';
import 'package:neurooooo/main_features/midas_assessment/midas.dart';

class QuestionnairePage extends StatelessWidget {
  const QuestionnairePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'We don’t know each other yet',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF16666B), // Text color matching the theme
              ),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MIDASAssessmentPage()),
                ); // Navigate to the homepage
              },
              child: Image.asset(
                'assets/images/plus.png',
                height: 50, // Adjust the height as needed
              ),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                ); // Navigate to the homepage
              },
              child: const Text(
                'Skip the questionnaire for now',
                style: TextStyle(
                  color: Color(0xFF16666B), // Text color matching the theme
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
