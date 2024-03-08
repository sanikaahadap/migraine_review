import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neurooooo/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  bool? _didMissMeals;
  double _glassesOfWater = 0;
  bool? _didExerciseToday;
  bool? _productiveObstacles;

  void _submitDiary() async {
    // Create a map with the values to be stored
    Map<String, dynamic> diaryData = {
      'didMissMeals': _didMissMeals,
      'glassesOfWater': _glassesOfWater,
      'didExerciseToday': _didExerciseToday,
      'productiveObstacles': _productiveObstacles,
      'timestamp': DateTime.now(),
      'uid': FirebaseAuth.instance.currentUser?.uid,
    };

    try {
      // Add the data to the Firestore collection 'personal_diary'
      await FirebaseFirestore.instance.collection('personal_diary').add(diaryData);

      // Navigate to the submission confirmation page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SubmissionConfirmationPage()),
      );
    } catch (e) {
      // Handle errors here
      print('Error adding diary entry: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF16666B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Your Diary',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF16666B),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              currentDate,
              style: const TextStyle(
                fontSize: 18.0,
                color: Color(0xFF16666B),
              ),
            ),
            const SizedBox(height: 20),



            Row(
              children: [
                const Text(
                  'Did you miss meals? ',
                  style: TextStyle(
                    color: Color(0xFF16666B),
                  ),
                ),
                Radio(
                  value: true,
                  groupValue: _didMissMeals,
                  activeColor: const Color(0xFF16666B),
                  onChanged: (value) {
                    setState(() {
                      _didMissMeals = value;
                    });
                  },
                ),
                const Text('Yes', style: TextStyle(color: Color(0xFF16666B))),
                Radio(
                  value: false,
                  groupValue: _didMissMeals,
                  activeColor: const Color(0xFF16666B),
                  onChanged: (value) {
                    setState(() {
                      _didMissMeals = value;
                    });
                  },
                ),
                const Text('No', style: TextStyle(color: Color(0xFF16666B))),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Glasses of Water:',
              style: TextStyle(
                color: Color(0xFF16666B),
              ),
            ),
            SliderTheme(
              data: const SliderThemeData(
                activeTrackColor: Color(0xFF16666B),
                thumbColor: Color(0xFF16666B),
                overlayColor: Color(0x2916666B),
                inactiveTrackColor: Colors.grey,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 16.0),
              ),
              child: Slider(
                value: _glassesOfWater,
                min: 0,
                max: 10,
                divisions: 10,
                label: _glassesOfWater.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _glassesOfWater = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                10,
                    (index) => _buildWaterIcon(index),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'Did you exercise today?',
                  style: TextStyle(
                    color: Color(0xFF16666B),
                  ),
                ),
                Radio(
                  value: true,
                  groupValue: _didExerciseToday,
                  activeColor: const Color(0xFF16666B),
                  onChanged: (value) {
                    setState(() {
                      _didExerciseToday = value;
                    });
                  },
                ),
                const Text('Yes', style: TextStyle(color: Color(0xFF16666B))),
                Radio(
                  value: false,
                  groupValue: _didExerciseToday,
                  activeColor: const Color(0xFF16666B),
                  onChanged: (value) {
                    setState(() {
                      _didExerciseToday = value;
                    });
                  },
                ),
                const Text('No', style: TextStyle(color: Color(0xFF16666B))),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Are you facing any obstacles being productive?',
              style: TextStyle(
                color: Color(0xFF16666B),
              ),
            ),
            Row(
              children: [
                Radio(
                  value: true,
                  groupValue: _productiveObstacles,
                  activeColor: const Color(0xFF16666B),
                  onChanged: (value) {
                    setState(() {
                      _productiveObstacles = value;
                    });
                  },
                ),
                const Text('Yes', style: TextStyle(color: Color(0xFF16666B))),
                Radio(
                  value: false,
                  groupValue: _productiveObstacles,
                  activeColor: const Color(0xFF16666B),
                  onChanged: (value) {
                    setState(() {
                      _productiveObstacles = value;
                    });
                  },
                ),
                const Text('No', style: TextStyle(color: Color(0xFF16666B))),
              ],
            ),
            const Spacer(),
            ElevatedButton(
               onPressed: _submitDiary,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16666B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterIcon(int index) {
    IconData iconData = _glassesOfWater >= index + 1 ? Icons.local_drink : Icons.local_drink_outlined;
    Color iconColor = _glassesOfWater >= index + 1 ? const Color(0xFF16666B) : Colors.grey;

    return Icon(iconData, color: iconColor);
  }
}

class SubmissionConfirmationPage extends StatelessWidget {
  const SubmissionConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF16666B),
        title: const Text('Submission Confirmation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Today's response recorded!",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF16666B),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16666B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: const Text('Go back to the home page'),
            ),
          ],
        ),
      ),
    );
  }
}
