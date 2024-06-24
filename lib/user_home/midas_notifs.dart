import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MidasNotifs extends StatefulWidget {
  const MidasNotifs({super.key});

  @override
  State<MidasNotifs> createState() => _MidasNotifsState();
}

class _MidasNotifsState extends State<MidasNotifs> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final String _uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    requestPermissions();
    listenToNotifications();
    _checkAndScheduleNotification();
  }

  requestPermissions() async {
    if (await Permission.notification.request().isGranted) {
      print("Notification permission granted");
    } else {
      print("Notification permission denied");
    }
  }

  listenToNotifications() {
    print("Listening to notification");
    LocalNotifications.onClickNotification.stream.listen((event) {
      print(event);
      Navigator.pushNamed(context, '/another', arguments: event);
    });
  }

  Future<void> _checkAndScheduleNotification() async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (userDoc.exists) {
      Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
      Timestamp? lastFilledTimestamp =
          data?['lastMIDASFilledTimestamp'] as Timestamp?;
      if (lastFilledTimestamp != null) {
        DateTime lastFilledDateTime = lastFilledTimestamp.toDate();
        DateTime now = DateTime.now();
        if (now.isAfter(lastFilledDateTime.add(Duration(days: 179)))) {
          LocalNotifications.scheduleDailyNotification();
        } else {
          print('Notification not needed yet.');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.notifications_outlined),
      onPressed: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: 19, minute: 0),
        );

        if (pickedTime != null) {
          await _saveNotificationTime(pickedTime);
          LocalNotifications.scheduleDailyNotification();
        }
      },
      label: Text("Schedule a daily notification for MIDAS"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF16666B), // background color
        foregroundColor: Colors.white, // text and icon color
      ),
    );
  }

  Future<void> _saveNotificationTime(TimeOfDay time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('notification_hour', time.hour);
    await prefs.setInt('notification_minute', time.minute);
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
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    final LinuxInitializationSettings initializationSettingsLinux =
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

  // schedule a daily notification
  static Future<void> scheduleDailyNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int hour = prefs.getInt('notification_hour') ?? 19; // Default to 7 PM
    int minute =
        prefs.getInt('notification_minute') ?? 0; // Default to 0 minutes

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    ).add(Duration(days: 1)); // Schedule for the next day

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    print('Scheduling notification for: $scheduledDate');

    await _flutterLocalNotificationsPlugin
        .zonedSchedule(
      0,
      'MIDAS Reminder',
      'It\'s time to fill up your MIDAS Assessment again',
      scheduledDate,
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    )
        .catchError((error) {
      print('Error scheduling notification: $error');
    });
  }
}
