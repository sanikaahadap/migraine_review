import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neurooooo/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  DiaryPageState createState() => DiaryPageState();
}

class DiaryPageState extends State<DiaryPage> {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
    bool? hadHeadache; // Initialize as null
    bool? avoidRoutineActivities; // Initialize as null
    String? sleepDuration; // Initialize as null
    double screenTime = 0; // Initialize with a default value

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



            Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Did you have a headache today?',
                  style: TextStyle(
                    color: Color(0xFF16666B),
                  ),
                ),
                Row(
                  children: [
                    Radio(
                      value: true,
                      groupValue: hadHeadache,
                      activeColor: const Color(0xFF16666B),
                      onChanged: (value) {
                        setState(() {
                          hadHeadache = value;
                        });
                      },
                    ),
                    const Text('Yes', style: TextStyle(color: Color(0xFF16666B))),
                    Radio(
                      value: false,
                      groupValue: hadHeadache,
                      activeColor: const Color(0xFF16666B),
                      onChanged: (value) {
                        setState(() {
                          hadHeadache = value;
                        });
                      },
                    ),
                    const Text('No', style: TextStyle(color: Color(0xFF16666B))),
                  ],
                ),
                if (hadHeadache ?? false)
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        '1. Describe the headache experienced:',
                        style: TextStyle(
                          color: Color(0xFF16666B),
                        ),
                      ),
                      // Radio buttons for headache description
                      const SizedBox(height: 10),
                      const Text(
                        '2. What was the severity:',
                        style: TextStyle(
                          color: Color(0xFF16666B),
                        ),
                      ),
                      // Radio buttons for headache severity
                      const SizedBox(height: 10),
                      const Text(
                        '3. What was the headache accompanied by:',
                        style: TextStyle(
                          color: Color(0xFF16666B),
                        ),
                      ),
                      // Checkboxes for headache accompaniments
                      const SizedBox(height: 10),
                      const Text(
                        '4. Any symptoms before the headache:',
                        style: TextStyle(
                          color: Color(0xFF16666B),
                        ),
                      ),
                      // Checkboxes for pre-headache symptoms
                      const SizedBox(height: 10),
                      const Text(
                        '5. Did you identify any triggers today:',
                        style: TextStyle(
                          color: Color(0xFF16666B),
                        ),
                      ),
                      // Checkboxes for headache triggers
                      const SizedBox(height: 10),
                      const Text(
                        '6. Did the headache cause you to avoid routine activities?',
                        style: TextStyle(
                          color: Color(0xFF16666B),
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: true,
                            groupValue: avoidRoutineActivities,
                            activeColor: const Color(0xFF16666B),
                            onChanged: (value) {
                              setState(() {
                                avoidRoutineActivities = value;
                              });
                            },
                          ),
                          const Text('Yes', style: TextStyle(color: Color(0xFF16666B))),
                          Radio(
                            value: false,
                            groupValue: avoidRoutineActivities,
                            activeColor: const Color(0xFF16666B),
                            onChanged: (value) {
                              setState(() {
                                avoidRoutineActivities = value;
                              });
                            },
                          ),
                          const Text('No', style: TextStyle(color: Color(0xFF16666B))),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'a) Did you miss meals?',
              style: TextStyle(
                color: Color(0xFF16666B),
              ),
            ),
            Row(
              children: [
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
              'b) Glasses of Water:',
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
            const Text(
              'c) Did you exercise today?',
              style: TextStyle(
                color: Color(0xFF16666B),
              ),
            ),
            Row(
              children: [
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
              'd) Are you facing any obstacles in being productive?',
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
            const SizedBox(height: 20),
            const Text(
              'e) How much sleep did you get?',
              style: TextStyle(
                color: Color(0xFF16666B),
              ),
            ),
            Row(
              children: [
                Radio(
                  value: sleepDuration == 'Less than 3 hours',
                  groupValue: sleepDuration,
                  activeColor: const Color(0xFF16666B),
                  onChanged: (value) {
                    setState(() {
                      sleepDuration = 'Less than 3 hours';
                    });
                  },
                ),
                const Text('< 3 hours', style: TextStyle(color: Color(0xFF16666B))),
                Radio(
                  value: sleepDuration == '3-5 hours',
                  groupValue: sleepDuration,
                  activeColor: const Color(0xFF16666B),
                  onChanged: (value) {
                    setState(() {
                      sleepDuration = '3-5 hours';
                    });
                  },
                ),
                const Text('3-5 hours', style: TextStyle(color: Color(0xFF16666B))),
                Radio(
                  value: sleepDuration == '5-8 hours',
                  groupValue: sleepDuration,
                  activeColor: const Color(0xFF16666B),
                  onChanged: (value) {
                    setState(() {
                      sleepDuration = '5-8 hours';
                    });
                  },
                ),
                const Text('5-8 hours', style: TextStyle(color: Color(0xFF16666B))),
                Radio(
                  value: sleepDuration == '8-10 hours',
                  groupValue: sleepDuration,
                  activeColor: const Color(0xFF16666B),
                  onChanged: (value) {
                    setState(() {
                      sleepDuration = '8-10 hours';
                    });
                  },
                ),
                const Text('8-10 hours', style: TextStyle(color: Color(0xFF16666B))),
                Radio(
                  value: sleepDuration == 'More than 10 hours',
                  groupValue: sleepDuration,
                  activeColor: const Color(0xFF16666B),
                  onChanged: (value) {
                    setState(() {
                      sleepDuration = 'More than 10 hours';
                    });
                  },
                ),
                const Text('> 10 hours', style: TextStyle(color: Color(0xFF16666B))),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'f) How many hours of screen time today?',
              style: TextStyle(
                color: Color(0xFF16666B),
              ),
            ),
            Row(
              children: [
                Slider(
                  value: screenTime,
                  min: 0,
                  max: 24,
                  divisions: 24,
                  label: screenTime.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      screenTime = value;
                    });
                  },
                ),
                Text('${screenTime.round()} hours', style: const TextStyle(color: Color(0xFF16666B))),
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
