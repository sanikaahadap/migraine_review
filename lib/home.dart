import 'package:flutter/material.dart';
import 'package:neurooooo/midas.dart';
import 'package:neurooooo/notifications.dart';
import 'package:neurooooo/settings.dart';
import 'package:neurooooo/ehr.dart';
import 'package:neurooooo/faqs.dart';
import 'package:neurooooo/calendar.dart';
import 'package:neurooooo/profile.dart';
import 'package:neurooooo/diary.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _userName = '';

  @override
  void initState() {
    super.initState();
    // Fetch user data here
    _userName = 'Test User'; // Placeholder user name
  }

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
                  _scaffoldKey.currentState!.openDrawer();
                },
                child: const Icon(
                  Icons.menu,
                  size: 40,
                  color: Color(0xFF16666B),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Hello $_userName',
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF16666B),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 5.5,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF16666B),
                    border: Border.all(color: const Color(0xFF16666B)),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Center(
                    child: Text(
                      'Fasting increases the risk of migraines',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFFFFFFFF),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 45),
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
                    const SizedBox(width: 20),
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
                const SizedBox(height: 20),
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
                    const SizedBox(width: 20),
                    CustomButton(
                      buttonText: 'Your Diary',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DiaryPage()),
                        );// Handle Your Diary button press
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );// Navigate to profile page
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Questionnaire'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MIDASAssessmentPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Your Diary'),
              onTap: () {
                // Navigate to your diary page
              },
            ),
            ListTile(
              title: const Text('Calendar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()),
                );
              },
            ),
            ListTile(
              title: const Text('EHR'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EHRPage()),
                );
              },
            ),
            ListTile(
              title: const Text('FAQs'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FAQsPage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                // Implement log out functionality
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
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(color: Color(0xFF16666B)),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 18.0,
            color: Color(0xFF16666B),
          ),
        ),
      ),
    );
  }
}
