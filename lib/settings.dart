import 'package:flutter/material.dart';
import 'package:neurooooo/theme_settings.dart'; // Import the ThemeSettingsPage

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF16666B), // Use the theme color for the app bar
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Profile Settings'),
            leading: const Icon(Icons.person, color: Color(0xFF16666B)), // Use theme color for the icon
            onTap: () {
              // Handle tapping on profile settings
            },
          ),
          ListTile(
            title: const Text('Notification Preferences'),
            leading: const Icon(Icons.notifications_active, color: Color(0xFF16666B)), // Use theme color for the icon
            onTap: () {
              // Handle tapping on notification preferences
            },
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            leading: const Icon(Icons.privacy_tip, color: Color(0xFF16666B)), // Use theme color for the icon
            onTap: () {
              // Handle tapping on privacy policy
            },
          ),
          ListTile(
            title: const Text('Change Theme'),
            leading: const Icon(Icons.color_lens, color: Color(0xFF16666B)), // Use theme color for the icon
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ThemeSettingsPage()),
              );
            },
          ),
        ],
      ),
    );


  }
}
