import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neurooooo/user_home/nav_bar.dart';

class YesPage extends StatefulWidget {
  const YesPage({super.key});

  @override
  YesPageState createState() => YesPageState();
}

class YesPageState extends State<YesPage> {
  String? _headacheDescription;
  String? _headacheSeverity;
  final List<String> _headacheAccompaniedBy = [];
  final List<String> _preHeadacheSymptoms = [];
  final List<String> _headacheTriggers = [];
  String? _avoidRoutineActivitiesAnswer;
  String? _missedMeals;
  double _glassesOfWater = 0;
  bool? _didExerciseToday;
  bool? _productiveObstacles;
  String? _sleepDuration;
  String? _exerciseDuration;
  String? _screenTime;
  String? _migraineDescription;



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
            const Text('1. Describe the headache experienced:', style: TextStyle(color: Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RadioListTile<String>(
                  title: const Text('Throbbing', style: TextStyle(color: Color(0xFF16666B))),
                  value: 'Throbbing',
                  groupValue: _headacheDescription,
                  onChanged: (value) {
                    setState(() {
                      _headacheDescription = value;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                RadioListTile<String>(
                  title: const Text('Pulsating', style: TextStyle(color: Color(0xFF16666B))),
                  value: 'Pulsating',
                  groupValue: _headacheDescription,
                  onChanged: (value) {
                    setState(() {
                      _headacheDescription = value;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                RadioListTile<String>(
                  title: const Text('Sharp', style: TextStyle(color: Color(0xFF16666B))),
                  value: 'Sharp',
                  groupValue: _headacheDescription,
                  onChanged: (value) {
                    setState(() {
                      _headacheDescription = value;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                RadioListTile<String>(
                  title: const Text('Tight', style: TextStyle(color: Color(0xFF16666B))),
                  value: 'Tight',
                  groupValue: _headacheDescription,
                  onChanged: (value) {
                    setState(() {
                      _headacheDescription = value;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                RadioListTile<String>(
                  title: const Text('Other', style: TextStyle(color: Color(0xFF16666B))),
                  value: 'Other',
                  groupValue: _headacheDescription,
                  onChanged: (value) {
                    setState(() {
                      _headacheDescription = value;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('2. What was the severity:', style: TextStyle(color: Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _headacheSeverity,
              onChanged: (String? value) {
                setState(() {
                  _headacheSeverity = value;
                });
              },
              items: <String>[
                'Mild',
                'Moderate',
                'Severe',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(color: Color(0xFF16666B)), textAlign: TextAlign.center,),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('3. What was the headache accompanied by:', style: TextStyle(color: Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CheckboxListTile(
                  title: const Text('Neck pain', style: TextStyle(color: Color(0xFF16666B))),
                  value: _headacheAccompaniedBy.contains('Neck pain'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _headacheAccompaniedBy.add('Neck pain');
                      } else {
                        _headacheAccompaniedBy.remove('Neck pain');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Nausea', style: TextStyle(color: Color(0xFF16666B))),
                  value: _headacheAccompaniedBy.contains('Nausea'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _headacheAccompaniedBy.add('Nausea');
                      } else {
                        _headacheAccompaniedBy.remove('Nausea');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Vomiting', style: TextStyle(color: Color(0xFF16666B))),
                  value: _headacheAccompaniedBy.contains('Vomiting'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _headacheAccompaniedBy.add('Vomiting');
                      } else {
                        _headacheAccompaniedBy.remove('Vomiting');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Visual disturbances', style: TextStyle(color: Color(0xFF16666B))),
                  value: _headacheAccompaniedBy.contains('Visual disturbances'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _headacheAccompaniedBy.add('Visual disturbances');
                      } else {
                        _headacheAccompaniedBy.remove('Visual disturbances');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('4. Any symptoms before the headache:', style: TextStyle(color: Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CheckboxListTile(
                  title: const Text('Visual flickering lights', style: TextStyle(color: Color(0xFF16666B))),
                  value: _preHeadacheSymptoms.contains('Visual flickering lights'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _preHeadacheSymptoms.add('Visual flickering lights');
                      } else {
                        _preHeadacheSymptoms.remove('Visual flickering lights');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Colored lights', style: TextStyle(color: Color(0xFF16666B))),
                  value: _preHeadacheSymptoms.contains('Colored lights'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _preHeadacheSymptoms.add('Colored lights');
                      } else {
                        _preHeadacheSymptoms.remove('Colored lights');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Tunnel-like vision', style: TextStyle(color: Color(0xFF16666B))),
                  value: _preHeadacheSymptoms.contains('Tunnel-like vision'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _preHeadacheSymptoms.add('Tunnel-like vision');
                      } else {
                        _preHeadacheSymptoms.remove('Tunnel-like vision');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('5. Is the headache triggered by:', style: TextStyle(color: Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CheckboxListTile(
                  title: const Text('Cold drinks', style: TextStyle(color: Color(0xFF16666B))),
                  value: _headacheTriggers.contains('Cold drinks'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _headacheTriggers.add('Cold drinks');
                      } else {
                        _headacheTriggers.remove('Cold drinks');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Tea', style: TextStyle(color: Color(0xFF16666B))),
                  value: _headacheTriggers.contains('Tea'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _headacheTriggers.add('Tea');
                      } else {
                        _headacheTriggers.remove('Tea');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Coffee', style: TextStyle(color: Color(0xFF16666B))),
                  value: _headacheTriggers.contains('Coffee'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _headacheTriggers.add('Coffee');
                      } else {
                        _headacheTriggers.remove('Coffee');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Strong smells', style: TextStyle(color: Color(0xFF16666B))),
                  value: _headacheTriggers.contains('Strong smells'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _headacheTriggers.add('Strong smells');
                      } else {
                        _headacheTriggers.remove('Strong smells');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Traveling', style: TextStyle(color: Color(0xFF16666B))),
                  value: _headacheTriggers.contains('Traveling'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _headacheTriggers.add('Traveling');
                      } else {
                        _headacheTriggers.remove('Traveling');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Mobile phone usage', style: TextStyle(color: Color(0xFF16666B))),
                  value: _headacheTriggers.contains('Mobile phone usage'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _headacheTriggers.add('Mobile phone usage');
                      } else {
                        _headacheTriggers.remove('Mobile phone usage');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Allergy', style: TextStyle(color: Color(0xFF16666B))),
                  value: _headacheTriggers.contains('Allergy'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _headacheTriggers.add('Allergy');
                      } else {
                        _headacheTriggers.remove('Allergy');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Excess/lack of sleep', style: TextStyle(color: Color(0xFF16666B))),
                  value: _headacheTriggers.contains('Excess/lack of sleep'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _headacheTriggers.add('Excess/lack of sleep');
                      } else {
                        _headacheTriggers.remove('Excess/lack of sleep');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Not sure', style: TextStyle(color: Color(0xFF16666B))),
                  value: _headacheTriggers.contains('Not sure'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _headacheTriggers.add('Not sure');
                      } else {
                        _headacheTriggers.remove('Not sure');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('6. Did the headache cause you to avoid routine activities:', style: TextStyle(color: Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'Yes',
                  groupValue: _avoidRoutineActivitiesAnswer,
                  onChanged: (value) {
                    setState(() {
                      _avoidRoutineActivitiesAnswer = value;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                const Text('Yes', style: TextStyle(color: Color(0xFF16666B))),
                Radio<String>(
                  value: 'No',
                  groupValue: _avoidRoutineActivitiesAnswer,
                  onChanged: (value) {
                    setState(() {
                      _avoidRoutineActivitiesAnswer = value;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                const Text('No', style: TextStyle(color: Color(0xFF16666B))),
              ],
            ),
            const SizedBox(height: 20),
            const Text('7. Describe the migraine you experienced today:', style: TextStyle(color: Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  _migraineDescription = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF16666B)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF16666B)),
                ),
                hintText: 'Enter your description here',
              ),
              cursorColor: const Color(0xFF16666B),
              maxLines: 5,
              style: const TextStyle(color: Color(0xFF16666B)),
            ),
            const SizedBox(height: 20),
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
                '1-2 hours hours',
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
                  'headacheDescription': _headacheDescription,
                  'headacheSeverity': _headacheSeverity,
                  'headacheAccompaniedBy': _headacheAccompaniedBy,
                  'preHeadacheSymptoms': _preHeadacheSymptoms,
                  'headacheTriggers': _headacheTriggers,
                  'avoidRoutineActivitiesAnswer': _avoidRoutineActivitiesAnswer,
                  'missedMeals': _missedMeals,
                  'glassesOfWater': _glassesOfWater,
                  'didExerciseToday': _didExerciseToday,
                  'productiveObstacles': _productiveObstacles,
                  'sleepDuration': _sleepDuration,
                  'exerciseDuration': _exerciseDuration,
                  'screenTime': _screenTime,
                  'migraineDescription': _migraineDescription,
                  'timestamp': Timestamp.now(),
                  'uid' : FirebaseAuth.instance.currentUser!.uid,
                };

                // Add data to Firestore
                FirebaseFirestore.instance.collection('headache_occurence_entries').add(formData)
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
