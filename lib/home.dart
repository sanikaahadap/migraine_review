import 'package:flutter/material.dart';
import 'package:neurooooo/midas.dart';
import 'package:neurooooo/notifications.dart';
import 'package:neurooooo/settings.dart';
import 'package:neurooooo/ehr.dart';
import 'package:neurooooo/faqs.dart';
import 'package:neurooooo/calendar.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 35), // Adjust left padding as needed
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  // Open drawer when icon is tapped
                  _scaffoldKey.currentState!.openDrawer();
                },
                child: const Icon(
                  Icons.menu, // Placeholder icon for sidebar
                  size: 40, // Adjust icon size as needed
                  color: Color(0xFF16666B), // Adjust icon color
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Hello User', // Added text
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold, // Bold font weight
                    color: Color(0xFF16666B), // Text color
                  ),
                ),
                const SizedBox(height: 20), // Adjust spacing
                Container(
                  width: double.infinity, // Cover entire page width
                  height: MediaQuery.of(context).size.height / 5.5, // 1/3 of the screen height
                  margin: const EdgeInsets.symmetric(horizontal: 20.0), // Adjust margin as needed
                  padding: const EdgeInsets.all(20.0), // Adjust padding as needed
                  decoration: BoxDecoration(
                    color: Color(0xFF16666B), // Transparent background
                    border: Border.all(color: const Color(0xFF16666B)), // Border color
                    borderRadius: BorderRadius.circular(20.0), // Rounded borders
                  ),
                  child: const Center(
                    child: Text(
                      'Fasting increases the risk of migraines',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFFFFFFFF), // Text color

                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 45), // Adjust spacing between box and buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      buttonText: 'EHR',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EHRPage()),
                        );
                      },
                    ),
                    const SizedBox(width: 20), // Adjust spacing between buttons as needed
                    CustomButton(
                      buttonText: 'Calendar',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CalendarPage()),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Adjust spacing between button rows as needed
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      buttonText: 'FAQs',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FAQsPage()),
                        );
                      },
                    ),
                    const SizedBox(width: 20), // Adjust spacing between buttons as needed
                    CustomButton(
                      buttonText: 'Your Diary',
                      onPressed: () {
                        // Handle Your Diary button press
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Adjust spacing between button rows as needed
                CustomButton(
                  buttonText: 'Migraine Assessment',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MIDASAssessmentPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF16666B),
              ),
              child: Text(
                'Test user',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                // Implement log out functionality
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false); // Navigates to the login page and removes all other routes
              },
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: const Color(0xFF16666B),
        onTap: (int index) {
          if (index == 0) {
            // Navigate to home page
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationsPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          }
        },
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomButton({
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
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0), // Adjust padding for width and height
          backgroundColor: Colors.white, // White background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Rounded borders
            side: const BorderSide(color: Color(0xFF16666B)), // Outline color
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 18.0,
            color: Color(0xFF16666B), // Text color
          ),
        ),
      ),
    );
  }
}
