import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neurooooo/login/login_signup_page.dart';
import 'package:neurooooo/main_features/ehr/ehr_entry.dart';
import 'package:neurooooo/main_features/midas_assessment/midas.dart';
import 'package:neurooooo/onboarding/animated_page.dart';
import 'package:neurooooo/salient_features.dart';
import 'package:neurooooo/user_home/doctor_info_page.dart';
import 'package:neurooooo/user_home/settings.dart';
import 'package:neurooooo/main_features/faqs/faqs.dart';
import 'package:neurooooo/main_features/calendar/calendar.dart';
import 'package:neurooooo/user_home/profile.dart';
import 'package:neurooooo/main_features/personal_diary/diary.dart';
import 'package:neurooooo/main_features/migraine_logs/migraine_logs.dart';
import 'package:neurooooo/models/user.dart';
import '../main_features/youtube_tips/youtube_links.dart';
import 'dart:developer';
import 'dart:async';

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
  Timer? _timer;
  int _currentIndex = 0;
  final List<String> _texts = [
    'Fasting increases the risk of migraines',
    'Avoid stress and prevent migraine',
    'Limit screen time to prevent eye strain',
    'Good sleep -> Reduced migraine risk',
  ];

  @override
  void initState() {
    super.initState();
    getDetails();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _texts.length;
      });
    });
  }




  void getDetails() async {
    user = await getUserDetails();
    setState(() {});
  }

  void signUserOut(BuildContext context) {
    FirebaseAuth.instance.signOut().then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginSignupPage()),
      );
    });
  }

  Future<ModelUser> getUserDetails() async {
    User currentUser = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    DocumentSnapshot snap =
        await firebaseFirestore.collection('users').doc(currentUser.uid).get();
    log('sssssssss ${snap["email"]}');
    return ModelUser.fromSnap(snap);
  }
  Widget _buildCard({
    required BuildContext context,
    required VoidCallback onPressed,
    required Icon icon,
    required String label,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35, // Adjust the width as needed
      height: MediaQuery.of(context).size.height * 0.15, // Adjust the height as needed
      child: Card(
        color: const Color(0xFF16666B),
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 36, // Adjust the icon size as needed
                  height: 36, // Adjust the icon size as needed
                  child: icon,
                ),
                const SizedBox(height: 5),
                Flexible(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14, // Adjust the font size as needed

                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x00bfdad8).withOpacity(0.49), // Set the background color with opacity
        title: Text(
          'Hello ${user.name}',
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF16666B),
          ),
        ),
        centerTitle: true, // Center the title
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          child: const Icon(
            Icons.menu,
            size: 40,
            color: Color(0xFF16666B),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
              // Handle profile icon tap
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.person,
                size: 40,
                color: Color(0xFF16666B),
              ),
            ),
          ),
        ],
      ),

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




          Center(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 6,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF16666B),
                    border: Border.all(color: const Color(0xFF16666B)),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 1500),
                      child: FutureBuilder<void>(
                        future: Future.delayed(const Duration(seconds: 3), () {}),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Text(
                              _texts[_currentIndex],
                              key: ValueKey<int>(_currentIndex),
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFFFFFFFF),
                              ),
                              textAlign: TextAlign.center,
                            );
                          } else {
                            _currentIndex = (_currentIndex + 1) % _texts.length;
                            return Text(
                              _texts[_currentIndex],
                              key: ValueKey<int>(_currentIndex),
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFFFFFFFF),
                              ),
                              textAlign: TextAlign.center,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCard(
                      context: context,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Ehrmainpg()),
                        );
                      },
                      icon: const Icon(Icons.assignment, color: Colors.white),
                      label: 'EHR',
                    ),
                    const SizedBox(width: 20),
                    _buildCard(
                      context: context,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CalendarPage()),
                        );
                      },
                      icon: const Icon(Icons.calendar_today, color: Colors.white),
                      label: 'Calendar',
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Row 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCard(
                      context: context,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const FAQsPage()),
                        );
                      },
                      icon: const Icon(Icons.help_outline, color: Colors.white),
                      label: 'FAQs',
                    ),
                    const SizedBox(width: 20),
                    _buildCard(
                      context: context,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DiaryPage()),
                        );
                      },
                      icon: const Icon(Icons.book, color: Colors.white),
                      label: 'Your Diary',
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Row 3
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCard(
                      context: context,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MIDASAssessmentPage()),
                        );
                      },
                      icon: const Icon(Icons.assessment, color: Colors.white),
                      label: 'Migraine Assessment',
                    ),
                    const SizedBox(width: 20),
                    _buildCard(
                      context: context,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MigraineLogsPage()),
                        );
                      },
                      icon: const Icon(Icons.assignment_turned_in, color: Colors.white),
                      label: 'Migraine Logs',
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
            SizedBox(
              height: 130, // Adjust the height as needed
              child: DrawerHeader(
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
            ),
            ListTile(
              leading: const Icon(Icons.videocam), // Icon for YT videos
              title: const Text('Youtube videos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Feed()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.healing), // Icon for Know Your Doctor
              title: const Text('Know Your Doctor'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DoctorInfoPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.app_shortcut_sharp), // Icon for FAQs
              title: const Text('Salient Features'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SalientFeaturesPage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout), // Icon for Log Out
              title: const Text('Log Out'),
              onTap:()=> signUserOut(context),
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

