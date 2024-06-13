import 'package:flutter/material.dart';

class PrivacyPolicyDescription extends StatelessWidget {
  const PrivacyPolicyDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF16666B),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Text(
                'Privacy Policy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'At NeuroCare, your privacy and confidentiality are our top priorities. All data you share with us is strictly between you and your doctor. We guarantee that your information will never be viewed or used by anyone else. Our app is committed to keeping your data secure and confidential. The information collected is solely used to provide you with personalized notifications and updates regarding your migraine health. Rest assured, your data is in safe hands with us.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}