import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'headache_no.dart';
import 'headache_yes.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:neurooooo/user_home/local_notifs.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  DiaryPageState createState() => DiaryPageState();
}

class DiaryPageState extends State<DiaryPage> {
  bool _canFillDiary = true;
  final String _uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _checkDiaryStatus();
  }

  Future<void> _setDiaryFilled() async {
    String today = DateTime.now().toIso8601String().split('T')[0];
    await FirebaseFirestore.instance.collection('users').doc(_uid).set({
      'lastFilledDate': today,
    }, SetOptions(merge: true));
    setState(() {
      _canFillDiary =
          false; // Update _canFillDiary after setting the diary filled
    });
    LocalNotifications
        .cancelNotification(); // Cancel the notification after diary is filled
  }

  Future<void> _checkDiaryStatus() async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (userDoc.exists) {
      Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
      String? lastFilledDate = data?['lastFilledDate'] as String?;
      String today = DateTime.now().toIso8601String().split('T')[0];

      TimeOfDay notificationTime = TimeOfDay(
          hour: 18, minute: 0); // Default time for notification at 6 PM

      // Check if the user has set a custom notification time
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (lastFilledDate == today) {
        setState(() {
          _canFillDiary = false;
        });
        LocalNotifications.cancelNotification();
      } else {
        setState(() {
          _canFillDiary = true;
        });
        LocalNotifications.scheduleNotificationAtTime();
      }

      if (prefs.containsKey('notificationHour') &&
          prefs.containsKey('notificationMinute')) {
        notificationTime = TimeOfDay(
          hour: prefs.getInt('notificationHour')!,
          minute: prefs.getInt('notificationMinute')!,
        );
      }

      // Construct the scheduled notification time
      final now = DateTime.now();
      final scheduledNotificationDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        notificationTime.hour,
        notificationTime.minute,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Diary', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF16666B),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Did you have a headache today?',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF16666B),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _canFillDiary
                  ? () {
                      _setDiaryFilled().then((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const YesPage()),
                        );
                      });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16666B),
              ),
              child: const Text('Yes', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _canFillDiary
                  ? () {
                      _setDiaryFilled().then((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NoPage()),
                        );
                      });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16666B),
              ),
              child: const Text('No', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            if (!_canFillDiary)
              const Text(
                'You have already filled the diary today, come again to fill it tomorrow',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
