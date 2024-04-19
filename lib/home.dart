import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neurooooo/ehr_entry.dart';
import 'package:neurooooo/midas.dart';
import 'package:neurooooo/settings.dart';
import 'package:neurooooo/faqs.dart';
import 'package:neurooooo/calendar.dart';
import 'package:neurooooo/profile.dart';
import 'package:neurooooo/diary.dart';
import 'package:neurooooo/miglog.dart';
import 'models/user.dart';
import 'dart:developer';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ModelUser user = ModelUser(
      email: '', name: '', uid: '', phone: '', dob: '', patient_id: '');
  // String _userName = '';

  @override
  void initState() {
    super.initState();
    // Fetch user data hereF
    // _userName = 'Test User';
    getDetails();
    // Placeholder user name
  }

  void getDetails() async {
    user = await getUserDetails();
    setState(() {});
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<ModelUser> getUserDetails() async {
    User currentUser = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    DocumentSnapshot snap =
        await firebaseFirestore.collection('users').doc(currentUser.uid).get();
    log('sssssssss ${snap["email"]}');
    return ModelUser.fromSnap(snap);
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
            padding: const EdgeInsets.only(
                left: 0, top: 35), // Adjust left padding as needed
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
                  'Hello ${user.name}',
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
                    color: const Color(0xFF16666B),
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
                const SizedBox(height: 40),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Ehrmainpg()),
                                );
                              },
                              icon: const Icon(Icons.assignment), // Icon for EHR
                              color: const Color(0xFF16666B),
                              iconSize: 52,
                            ),

                            const Text(
                              'EHR',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold, // Bold text
                                color: Color(0xFF16666B),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 60),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const CalendarPage()),
                                );
                              },
                              icon: const Icon(Icons.calendar_today), // Icon for Calendar
                              color: const Color(0xFF16666B),
                              iconSize: 52,
                            ),

                            const Text(
                              'Calendar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold, // Bold text
                                color: Color(0xFF16666B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10), // Vertical spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const FAQsPage()),
                                );
                              },
                              icon: const Icon(Icons.help_outline), // Icon for FAQs
                              color: const Color(0xFF16666B),
                              iconSize: 52,
                            ),

                            const Text(
                              'FAQs',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold, // Bold text
                                color: Color(0xFF16666B),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 60),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const DiaryPage()),
                                );
                              },
                              icon: const Icon(Icons.book), // Icon for Your Diary
                              color: const Color(0xFF16666B),
                              iconSize: 52,
                            ),

                            const Text(
                              'Your Diary',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold, // Bold text
                                color: Color(0xFF16666B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                     // Vertical spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 25),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MIDASAssessmentPage()),
                                );
                              },
                              icon: const Icon(Icons.assessment), // Icon for Migraine Assessment
                              color: const Color(0xFF16666B),
                              iconSize: 52,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Migraine\nAssessment',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold, // Bold text
                                color: Color(0xFF16666B),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(width: 40),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MigraineLogsPage()),
                                );
                              },
                              icon: const Icon(Icons.assignment_turned_in), // Icon for Migraine Logs
                              color: const Color(0xFF16666B),
                              iconSize: 52,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Migraine Logs',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold, // Bold text
                                color: Color(0xFF16666B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
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
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF16666B),
              ),
              child: Text(
                user.name.isNotEmpty
                    ? user.name
                    : 'Hello User', // Display user's name if not empty
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person), // Icon for Profile
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings), // Icon for Settings
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.assignment), // Icon for Questionnaire
              title: const Text('Questionnaire'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MIDASAssessmentPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book), // Icon for Your Diary
              title: const Text('Your Diary'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DiaryPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today), // Icon for Calendar
              title: const Text('Calendar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CalendarPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.assignment), // Icon for EHR
              title: const Text('EHR'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Ehrmainpg()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline), // Icon for FAQs
              title: const Text('FAQs'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FAQsPage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout), // Icon for Log Out
              title: const Text('Log Out'),
              onTap: signUserOut,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
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

