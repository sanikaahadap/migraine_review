import 'package:flutter/material.dart';
import 'package:neurooooo/theme_settings.dart'; // Import the ThemeSettingsPage

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(0xFF16666B), // Use the theme color for the app bar
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Profile Settings'),
            leading: Icon(Icons.person, color: Color(0xFF16666B)), // Use theme color for the icon
            onTap: () {
              // Handle tapping on profile settings
            },
          ),
          ListTile(
            title: Text('Notification Preferences'),
            leading: Icon(Icons.notifications_active, color: Color(0xFF16666B)), // Use theme color for the icon
            onTap: () {
              // Handle tapping on notification preferences
            },
          ),
          ListTile(
            title: Text('Privacy Policy'),
            leading: Icon(Icons.privacy_tip, color: Color(0xFF16666B)), // Use theme color for the icon
            onTap: () {
              // Handle tapping on privacy policy
            },
          ),
          ListTile(
            title: Text('Change Theme'),
            leading: Icon(Icons.color_lens, color: Color(0xFF16666B)), // Use theme color for the icon
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThemeSettingsPage()),
              );
            },
          ),
        ],
      ),
    );


  }
}
