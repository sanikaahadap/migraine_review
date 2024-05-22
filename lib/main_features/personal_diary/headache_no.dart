import 'dart:developer';
import 'package:neurooooo/user_home/nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NoPage extends StatefulWidget {
  const NoPage({super.key});

  @override
  NoPageState createState() => NoPageState();
}

class NoPageState extends State<NoPage> {
  String? _missedMeals;
  double _glassesOfWater = 0;
  bool? _didExerciseToday;
  bool? _productiveObstacles;
  String? _sleepDuration;
  String? _exerciseDuration;
  String? _screenTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF16666B),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Did you miss meals?', style: TextStyle(color: Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'Yes',
                  groupValue: _missedMeals,
                  onChanged: (value) {
                    setState(() {
                      _missedMeals = value;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                const Text('Yes', style: TextStyle(color: Color(0xFF16666B))),
                Radio<String>(
                  value: 'No',
                  groupValue: _missedMeals,
                  onChanged: (value) {
                    setState(() {
                      _missedMeals = value;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                const Text('No', style: TextStyle(color: Color(0xFF16666B))),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Glasses of Water:', style: TextStyle(color: Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
                Slider(
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
                  activeColor: const Color(0xFF16666B),
                ),
                Text('Glasses: ${_glassesOfWater.toInt()}', style: const TextStyle(color: Color(0xFF16666B))),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Did you exercise today?', style: TextStyle(color: Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: <Widget>[
                Radio<bool>(
                  value: true,
                  groupValue: _didExerciseToday,
                  onChanged: (value) {
                    setState(() {
                      _didExerciseToday = value;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                const Text('Yes', style: TextStyle(color: Color(0xFF16666B))),
                Radio<bool>(
                  value: false,
                  groupValue: _didExerciseToday,
                  onChanged: (value) {
                    setState(() {
                      _didExerciseToday = value;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                const Text('No', style: TextStyle(color: Color(0xFF16666B))),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Are you facing any obstacles in being productive?', style: TextStyle(color: Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: <Widget>[
                Radio<bool>(
                  value: true,
                  groupValue: _productiveObstacles,
                  onChanged: (value) {
                    setState(() {
                      _productiveObstacles = value;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                const Text('Yes', style: TextStyle(color: Color(0xFF16666B))),
                Radio<bool>(
                  value: false,
                  groupValue: _productiveObstacles,
                  onChanged: (value) {
                    setState(() {
                      _productiveObstacles = value;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                const Text('No', style: TextStyle(color: Color(0xFF16666B))),
              ],
            ),
            const SizedBox(height: 20),
            const Text('How much sleep did you get?', style: TextStyle(color: Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _sleepDuration,
              onChanged: (String? value) {
                setState(() {
                  _sleepDuration = value;
                });

              },
              items: <String>[
                'Less than 3 hours',
                '3-5 hours',
                '5-8 hours',
                '8-10 hours',
                'More than 10 hours',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(color: Colors.black)),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('For how long did you exercise? (in hours/minutes)', style: TextStyle(color: Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _exerciseDuration,
              onChanged: (String? value) {
                setState(() {
                  _exerciseDuration = value;
                });
              },
              items: <String>[
                'Did not exercise',
                '15-20 minutes',
                '20-60 minutes',
                'Between 1 to 2 hours',
                'More than 2 hours',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(color: Colors.black)),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('How long do you work on mobile phones or computers? (in hours)', style: TextStyle(color: Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _screenTime,
              onChanged: (String? value) {
                setState(() {
                  _screenTime = value;
                });
              },
              items: <String>[
                'Less than an hour',
                '1-2 hours',
                '2-4 hours',
                '4-6 hours',
                'More than 6 hours',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(color: Colors.black)),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Gather all the data collected
                Map<String, dynamic> formData = {
                  'missedMeals': _missedMeals,
                  'glassesOfWater': _glassesOfWater,
                  'didExerciseToday': _didExerciseToday,
                  'productiveObstacles': _productiveObstacles,
                  'sleepDuration': _sleepDuration,
                  'exerciseDuration': _exerciseDuration,
                  'screenTime': _screenTime,
                  'timestamp': Timestamp.now(),
                  'uid' : FirebaseAuth.instance.currentUser!.uid,
                };

                // Add data to Firestore
                FirebaseFirestore.instance.collection('no_headache_entries').add(formData)
                    .then((value) {
                  log("Data added successfully");
                  // Show success message
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirmation"),
                        content: const Text("Are you sure you want to submit this response?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              // Close the dialog
                              Navigator.of(context).pop();
                              // Navigate to the new page
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CustomBottomNavigationBar()),
                              );
                            },
                            child: const Text("Yes"),
                          ),
                          TextButton(
                            onPressed: () {
                              // Close the dialog without navigating
                              Navigator.of(context).pop();
                            },
                            child: const Text("No"),
                          ),
                        ],
                      );
                    },
                  );
                }).catchError((error) {
                  log("Failed to add data: $error");
                  // Handle errors appropriately, such as showing an error message to the user.
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF16666B)),
              child: const Text('Submit', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
