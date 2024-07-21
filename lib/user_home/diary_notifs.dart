import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:rxdart/rxdart.dart';

class Notifs extends StatefulWidget {
  const Notifs({Key? key}) : super(key: key);

  @override
  State<Notifs> createState() => _NotifsState();
}

class _NotifsState extends State<Notifs> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final int _defaultHour = 18; // Default notification time hour (7 PM)
  final int _defaultMinute = 0; // Default notification time minute

  @override
  void initState() {
    super.initState();
    requestPermissions();
    listenToNotifications();
    _scheduleDailyNotification();
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

  Future<void> _scheduleDailyNotification() async {
    // Schedule the notification for 7 PM daily
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      _defaultHour,
      _defaultMinute,
    );

    // If the scheduled time is before the current time, schedule for the next day
    final tz.TZDateTime finalScheduledDate = scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;

    // Schedule the notification
    await LocalNotifications.scheduleDailyNotification(finalScheduledDate);

    // Print the scheduled date and time for verification
    print('Scheduled daily Diary Notification for: $finalScheduledDate');
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
                  'Diary Notification',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Scheduled daily at 6:00 PM',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.0),
                ElevatedButton.icon(
                  icon: Icon(Icons.notifications_outlined),
                  onPressed: () {
                    _scheduleDailyNotification();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Diary notification scheduled daily at 6:00 PM',
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
                  label: Text("Enable Diary notification"),
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

  // schedule a daily notification
  static Future<void> scheduleDailyNotification(
      tz.TZDateTime scheduledDate) async {
    await _flutterLocalNotificationsPlugin
        .zonedSchedule(
      0,
      'Have you filled your diary today?',
      'If not then please fill your diary',
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
      print('Error scheduling notification: $error');
    });
  }
}
