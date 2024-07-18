import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MidasNotifs extends StatefulWidget {
  const MidasNotifs({Key? key}) : super(key: key);

  @override
  State<MidasNotifs> createState() => _MidasNotifsState();
}

class _MidasNotifsState extends State<MidasNotifs> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final String _uid = FirebaseAuth.instance.currentUser!.uid;
  final int _defaultHour = 19; // Default notification time hour (7 PM)
  final int _defaultMinute = 0; // Default notification time minute
  String _nextMIDASDate = ''; // Variable to store the next MIDAS test date

  @override
  void initState() {
    super.initState();
    requestPermissions();
    listenToNotifications();
    _checkAndScheduleNotification();
    _fetchNextMIDASDate();
  }

  requestPermissions() async {
    if (await Permission.notification.request().isGranted) {
      log("Notification permission granted");
    } else {
      log("Notification permission denied");
    }
  }

  listenToNotifications() {
    log("Listening to notification");
    LocalNotifications.onClickNotification.stream.listen((event) {
      log(event);
      Navigator.pushNamed(context, '/another', arguments: event);
    });
  }

  Future<void> _checkAndScheduleNotification() async {
    // Fetch the latest MIDAS score entry for the current user
    QuerySnapshot midasScores = await FirebaseFirestore.instance
        .collection('midas_scores')
        .where('uid', isEqualTo: _uid)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (midasScores.docs.isNotEmpty) {
      Timestamp lastMidasTimestamp =
          midasScores.docs.first.get('timestamp') as Timestamp;

      // Calculate the next MIDAS date 89 days after the latest timestamp
      DateTime lastMidasDateTime = lastMidasTimestamp.toDate();
      DateTime nextMidasDate = lastMidasDateTime.add(const Duration(days: 89));

      // Format the next MIDAS date
      String formattedNextMidasDate =
          "${nextMidasDate.day} ${_monthToString(nextMidasDate.month)} ${nextMidasDate.year}";

      // Set the next MIDAS date to be displayed
      setState(() {
        _nextMIDASDate = formattedNextMidasDate;
      });

      // Schedule the notification for the calculated date at 7 PM
      final int hour = 19; // 7 PM
      final int minute = 0; // 0 minutes

      final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
      final tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local,
        nextMidasDate.year,
        nextMidasDate.month,
        nextMidasDate.day,
        hour,
        minute,
      );

      // Schedule the notification
      await LocalNotifications.scheduleNotification(scheduledDate);

      // Print the scheduled date and time for verification
      print('Scheduled MIDAS Notification for: $scheduledDate');
    } else {
      log('No MIDAS score entries found.');
    }
  }

  Future<void> _fetchNextMIDASDate() async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (userDoc.exists) {
      Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
      Timestamp? lastFilledTimestamp = data?['timestamp'] as Timestamp?;
      if (lastFilledTimestamp != null) {
        DateTime lastFilledDateTime = lastFilledTimestamp.toDate();
        DateTime nextMIDASDate =
            lastFilledDateTime.add(const Duration(days: 89));
        setState(() {
          _nextMIDASDate =
              "${nextMIDASDate.day} ${_monthToString(nextMIDASDate.month)} ${nextMIDASDate.year}";
        });
      }
    }
  }

  String _monthToString(int month) {
    const List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          color: const Color(0xFF16666B),
          margin: EdgeInsets.all(16.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'MIDAS Notification',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  _nextMIDASDate.isNotEmpty
                      ? 'Scheduled for $_nextMIDASDate at 7:00 PM'
                      : 'Please attempt your MIDAS Assessment Test',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.0),
                ElevatedButton.icon(
                  icon: Icon(Icons.notifications_outlined),
                  onPressed: () {
                    _checkAndScheduleNotification();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'MIDAS notification scheduled for $_nextMIDASDate',
                          style: TextStyle(fontSize: 10),
                        ),
                        duration: Duration(seconds: 3),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                      ),
                    );
                  },
                  label: Text("Enable MIDAS notification"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF16666B),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

  // on tap on any notification
  static void onNotificationTap(NotificationResponse notificationResponse) {
    onClickNotification.add(notificationResponse.payload!);
  }

  // initialize the local notifications
  static Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation('Asia/Kolkata')); // Set your local time zone here

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/notif_icon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  // schedule a one-time notification
  static Future<void> scheduleNotification(tz.TZDateTime scheduledDate) async {
    await _flutterLocalNotificationsPlugin
        .zonedSchedule(
      0,
      'MIDAS Reminder',
      'It\'s time to fill up your MIDAS Assessment again',
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    )
        .catchError((error) {
      log('Error scheduling notification: $error');
    });
  }
}
