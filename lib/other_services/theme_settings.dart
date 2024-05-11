import 'package:flutter/material.dart';
import 'package:neurooooo/user_home/settings.dart';

class ThemeSettingsPage extends StatefulWidget {
  const ThemeSettingsPage({super.key});

  @override
  _ThemeSettingsPageState createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  bool _isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Theme'),
        backgroundColor: const Color(0xFF16666B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Theme:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF16666B),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text('Light Mode'),
              leading: Radio(
                value: false,
                groupValue: _isDarkModeEnabled,
                onChanged: (value) {
                  setState(() {
                    _isDarkModeEnabled = value as bool;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Dark Mode'),
              leading: Radio(
                value: true,
                groupValue: _isDarkModeEnabled,
                onChanged: (value) {
                  setState(() {
                    _isDarkModeEnabled = value as bool;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _applyTheme();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16666B),
              ),
              child: const Text(
                'Apply Theme',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyTheme() {
    // Update the theme locally
    if (_isDarkModeEnabled) {
      // Apply dark theme
      _applyDarkTheme();
    } else {
      // Apply light theme
      _applyLightTheme();
    }
  }

  void _applyDarkTheme() {
    // Update theme colors for dark mode
    // You can define your dark mode theme colors here
    // For demonstration purposes, let's just change the scaffold background color to dark grey
    // You can update other theme properties based on your preferences
    ThemeData darkTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.grey[900],
    );
    // Apply the dark theme
    _applyThemeColors(darkTheme);
  }

  void _applyLightTheme() {
    // Update theme colors for light mode
    // You can define your light mode theme colors here
    // For demonstration purposes, let's just change the scaffold background color to white
    // You can update other theme properties based on your preferences
    ThemeData lightTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
    );
    // Apply the light theme
    _applyThemeColors(lightTheme);
  }

  void _applyThemeColors(ThemeData themeData) {
    // Apply the updated theme colors
    Navigator.pop(context); // Close the settings page
    Navigator.pushReplacement( // Push a new home page with the updated theme
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
  }
}
