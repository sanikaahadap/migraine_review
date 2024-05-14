import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:neurooooo/other_services/firebase_options.dart';
import 'package:neurooooo/other_services/validation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => const Validate(),
      },
      title: 'NeuroCare',
      debugShowCheckedModeBanner: false,
      home: const Validate(),
    );
  }
}