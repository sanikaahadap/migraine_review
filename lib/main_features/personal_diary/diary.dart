import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'headache_no.dart';
import 'headache_yes.dart';
import 'dart:async';
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

  Future<void> _setQuestionnaireFilled() async {
    Timestamp now = Timestamp.now();
    await FirebaseFirestore.instance.collection('users').doc(_uid).set({
      'lastMIDASFilledTimestamp': now,
      'lastDiaryFilledTimestamp': now, // Update this field as well
    }, SetOptions(merge: true));
  }

// Update the logic to handle cases where the diary hasn't been filled by the specified time
  Future<void> _checkDiaryStatus() async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (userDoc.exists) {
      Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
      String? lastFilledDate = data?['lastFilledDate'] as String?;
      TimeOfDay? notificationTime = TimeOfDay(
          hour: 18, minute: 0); // Default time for notification at 6 PM

      // Check if the user has set a custom notification time
      if (data != null &&
          data['notificationHour'] != null &&
          data['notificationMinute'] != null) {
        notificationTime = TimeOfDay(
            hour: data['notificationHour'], minute: data['notificationMinute']);
      }

      // Construct the scheduled notification time
      final now = DateTime.now();
      final scheduledNotificationDateTime = DateTime(now.year, now.month,
          now.day, notificationTime.hour, notificationTime.minute);

      if (lastFilledDate != null &&
          DateTime.parse(lastFilledDate)
              .isBefore(scheduledNotificationDateTime)) {
        setState(() {
          _canFillDiary = true;
        });
        LocalNotifications.scheduleNotificationAtTime(notificationTime);
      } else {
        setState(() {
          _canFillDiary = false;
        });
        LocalNotifications.cancelNotification();
      }
    }
  }

  Future<void> _setDiaryFilled() async {
    String today = DateTime.now().toIso8601String().split('T')[0];
    await FirebaseFirestore.instance.collection('users').doc(_uid).set({
      'lastFilledDate': today,
    }, SetOptions(merge: true));
    LocalNotifications
        .cancelNotification(); // Cancel the notification after diary is filled
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
