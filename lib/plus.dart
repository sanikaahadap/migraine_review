import 'package:flutter/material.dart';
import 'package:neurooooo/home.dart';
import 'package:neurooooo/midas.dart';

class QuestionnairePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'We don’t know each other yet',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF16666B), // Text color matching the theme
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MIDASAssessmentPage()),
                ); // Navigate to the homepage
              },
              child: Image.asset(
                'assets/images/plus.png',
                height: 50, // Adjust the height as needed
              ),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                ); // Navigate to the homepage
              },
              child: Text(
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
