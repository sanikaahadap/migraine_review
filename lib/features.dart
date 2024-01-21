import 'package:flutter/material.dart';
import 'package:neurooooo/intro_screens/intro_page_1.dart';
import 'package:neurooooo/intro_screens/intro_page_2.dart';
import 'package:neurooooo/intro_screens/intro_page_3.dart';
import 'package:neurooooo/intro_screens/intro_page_4.dart';
import 'package:neurooooo/intro_screens/intro_page_5.dart';
import 'package:neurooooo/onboarding_screen.dart';

class Features extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'An app solely designed to elevate your migraine care journey, tailored uniquely for your needs.',
                style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              Text(
                'Features Offered',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Color(0xFF16666B)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              FeatureButton(
                imagePath: 'assets/intro_images/intro_1.png',
                buttonText: 'Track & Assess',
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IntroPage1()), // Navigate to intro_page_1.dart
                  );
                },
              ),
              FeatureButton(
                imagePath: 'assets/intro_images/intro_2.png',
                buttonText: 'Tailored Lifestyle Tips',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IntroPage2()), // Navigate to intro_page_1.dart
                  );
                },
              ),
              FeatureButton(
                imagePath: 'assets/intro_images/intro_3.png',
                buttonText: 'Personalized Reminders',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IntroPage3()), // Navigate to intro_page_1.dart
                  );
                },
              ),
              FeatureButton(
                imagePath: 'assets/intro_images/intro_4.png',
                buttonText: 'Your Diary',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IntroPage4()), // Navigate to intro_page_1.dart
                  );
                },
              ),
              FeatureButton(
                imagePath: 'assets/intro_images/intro_5.png',
                buttonText: 'FAQs',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IntroPage5()), // Navigate to intro_page_1.dart
                  );
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Click the buttons to know more about the features',
                style: TextStyle(fontSize: 12.0, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final String imagePath;
  final String buttonText;
  final VoidCallback onPressed;

  const FeatureButton({
    required this.imagePath,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
          backgroundColor: Colors.white, // White background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
            side: BorderSide(color: Color(0xFF16666B)), // Outline color
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              height: 50.0,
              width: 50.0,
              // Adjust the height and width as needed
            ),
            SizedBox(width: 16.0),
            Text(
              buttonText,
              style: TextStyle(
                fontSize: 18.0,
                color: Color(0xFF16666B), // Text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}