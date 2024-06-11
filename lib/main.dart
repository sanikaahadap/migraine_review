import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:neurooooo/other_services/firebase_options.dart';
import 'package:neurooooo/other_services/validation.dart';
import 'package:neurooooo/main_features/personal_diary/diary.dart';
import 'package:neurooooo/main_features/midas_assessment/midas.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:neurooooo/user_home/local_notifs.dart';

final navigatorKey = GlobalKey<NavigatorState>();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalNotifications.init();

//  handle in terminated state
  var initialNotification =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (initialNotification?.didNotificationLaunchApp == true) {
    // LocalNotifications.onClickNotification.stream.listen((event) {
    Future.delayed(Duration(seconds: 1), () {
      // print(event);
      navigatorKey.currentState!.pushNamed('/another',
          arguments: initialNotification?.notificationResponse?.payload);
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => const Validate(),
        '/diary': (context) => const DiaryPage(),
        '/midas': (context) => const MIDASAssessmentPage()
      },
      title: 'NeuroCare',
      debugShowCheckedModeBanner: false,
      home: const Validate(),
    );
  }
}
