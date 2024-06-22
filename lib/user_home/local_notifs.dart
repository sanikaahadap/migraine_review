import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  static Future<void> scheduleNotificationAtTime(TimeOfDay time) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    // Check if the scheduled time has already passed for today
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate
          .add(const Duration(days: 1)); // Schedule for the next day
    }

    // Schedule the notification
    await _flutterLocalNotificationsPlugin
        .zonedSchedule(
      0,
      'Diary Reminder',
      'Please fill your diary for today.',
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
      matchDateTimeComponents: DateTimeComponents.time,
    )
        .catchError((error) {
      print('Error scheduling daily notification: $error');
    });
  }

// Add functionality to request notification permissions
  static Future<void> requestNotificationPermissions() async {
    await Permission.notification.request();
  }

  // cancel the notification
  static Future<void> cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancel(0);
  }
}

class Notifs extends StatefulWidget {
  const Notifs({super.key});

  @override
  State<Notifs> createState() => _NotifsState();
}

class _NotifsState extends State<Notifs> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    requestPermissions();
    listenToNotifications();
  }

  requestPermissions() async {
    if (await Permission.scheduleExactAlarm.request().isGranted) {
      print("Exact alarm permission granted");
    } else {
      print("Exact alarm permission denied");
    }
  }

  listenToNotifications() {
    print("Listening to notification");
    LocalNotifications.onClickNotification.stream.listen((event) {
      print(event);
      Navigator.pushNamed(context, '/another', arguments: event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.notifications_outlined),
      onPressed: () async {
        final selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (selectedTime != null) {
          await LocalNotifications.scheduleNotificationAtTime(selectedTime);
        }
      },
      label: Text("Set Notification Time"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF16666B), // background color
        foregroundColor: Colors.white, // text and icon colort and icon color
      ),
    );
  }
}
