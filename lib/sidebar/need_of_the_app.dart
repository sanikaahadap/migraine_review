import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NeedOfTheApp extends StatelessWidget {
  const NeedOfTheApp({super.key});

  // Function to launch URL
  void _launchURL() async {
    const url = 'http://drbindumenon.com/';
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Need of the NeuroCare App',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // App photo
            Container(
              width: 250,
              height: 100,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/bmf_logo.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Migraine is a disabling disease. \n It is important for patients to understand the disease and to assist their treating doctors.',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                height: 1.5, // Better line height for readability
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              height: 40,
            ),
            const SizedBox(height: 16),
            const Text(
              'This app, created by the Dr. Bindu Menon Foundation,'
                  ' is designed to help patients understand and manage their migraines.',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                height: 1.5, // Better line height for readability
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _launchURL,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFB22222), // button color
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Learn More',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white, // White background
    );
  }
}
