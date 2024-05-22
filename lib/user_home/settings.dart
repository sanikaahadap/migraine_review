import 'package:flutter/material.dart';
import 'package:neurooooo/user_home/profile.dart';// Import the ThemeSettingsPage

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF16666B), // Use the theme color for the app bar
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Profile Info'),
            leading: const Icon(Icons.person, color: Color(0xFF16666B)), // Use theme color for the icon
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfilePage()),
              );
            },
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            leading: const Icon(Icons.privacy_tip, color: Color(0xFF16666B)), // Use theme color for the icon
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyDescription()),
              );
            },
          ),
        ],
      ),
    );
  }
}
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