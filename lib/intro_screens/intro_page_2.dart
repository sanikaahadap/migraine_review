import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class IntroPage2 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/intro_images/intro_2.png', // Replace 'your_image.png' with the actual image asset path
              width: 200, // Adjust the width as needed
              height: 200, // Adjust the height as needed
              // You can also use other properties like fit, alignment, etc.
            ),
            SizedBox(height: 16), // Adjust the spacing between image and text
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text(
                textAlign : TextAlign.center,
                'Tailored Lifestyle Tips',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(22, 102, 107, 1.0), // Adjust the text color as needed
                  fontSize: 30.0,
                ),
              ),
            ),
            SizedBox(height: 8), // Adjust the spacing between image and text
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Text(
                textAlign : TextAlign.center,
                'Curated advice, custom-fit for your lifestyle, empowering you to conquer migraines with practical, personalized guidance.',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.grey[700], // Adjust the text color as needed
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
