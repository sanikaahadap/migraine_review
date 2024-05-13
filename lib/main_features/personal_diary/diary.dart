import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiaryPage extends StatefulWidget {
  final String? headacheDescription;
  final String? headacheSeverity;
  final List<String>? headacheAccompaniedBy;
  final List<String>? preHeadacheSymptoms;
  final List<String>? headacheTriggers;
  final String? avoidRoutineActivitiesAnswer;

  final String? missedMeals;
  final double? glassesOfWater;
  final bool? didExerciseToday;
  final bool? productiveObstacles;
  final String? sleepDuration;
  final String? exerciseDuration;
  final String? screenTime;

  const DiaryPage({
    Key? key,
    this.headacheDescription,
    this.headacheSeverity,
    this.headacheAccompaniedBy,
    this.preHeadacheSymptoms,
    this.headacheTriggers,
    this.avoidRoutineActivitiesAnswer,
    this.missedMeals,
    this.glassesOfWater,
    this.didExerciseToday,
    this.productiveObstacles,
    this.sleepDuration,
    this.exerciseDuration,
    this.screenTime,
  }) : super(key: key);

  @override
  DiaryPageState createState() => DiaryPageState();
}

class DiaryPageState extends State<DiaryPage> {
  bool? _hadHeadache;
  // Future<void> _submitDiary() async {
  //   // Create a map with the values to be stored
  //   Map<String, dynamic> diaryData = {
  //     'durationIndex': _durationIndex,
  //     'painSeverity': _painSeverity,
  //     'selectedLocation': _selectedLocation,
  //     'selectedCharacter': _selectedCharacter,
  //     'selectedSeverity': _selectedSeverity,
  //     'difficultyInWork': _difficultyInWork,
  //     'nausea': _nausea,
  //     'vomiting': _vomiting,
  //     'photophobia': _photophobia,
  //     'phonophobia': _phonophobia,
  //     'osmophobia': _osmophobia,
  //     'blurringOfVision': _blurringOfVision,
  //     'ctMriScan': _ctMriScan,
  //     'painKillersPerMonth': _painKillersPerMonth,
  //     'monthsOfPainkillerUse': _monthsOfPainkillerUse,
  //     'timestamp': DateTime.now(),
  //   };
  //
  //   try {
  //     // Add the data to the Firestore collection 'diary_logs'
  //     await FirebaseFirestore.instance
  //         .collection('personal_diary')
  //         .add(diaryData);
  //
  //     // Navigate to the log response page or any other action
  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     builder: (context) => LogResponsePage(date: DateTime.now()),
  //     //   ),
  //     // );
  //   } catch (error) {
  //     // Handle any errors that occur during submission
  //     print('Error submitting diary: $error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Diary',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF16666B),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Did you have a headache today?',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF16666B),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _hadHeadache = true;

                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => YesPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF16666B),
              ),
              child: Text('Yes', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _hadHeadache = false;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NoPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF16666B),
              ),
              child: Text('No', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}


class YesPage extends StatefulWidget {
  @override
  YesPageState createState() => YesPageState();
}

class YesPageState extends State<YesPage> {
  String? _headacheDescription;
  String? _headacheSeverity;
  List<String> _headacheAccompaniedBy = [];
  List<String> _preHeadacheSymptoms = [];
  List<String> _headacheTriggers = [];
  String? _avoidRoutineActivitiesAnswer;

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
            Text('1. Describe the headache experienced:', style: TextStyle(color: const Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RadioListTile<String>(
                  title: const Text('Throbbing'),
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
                  title: const Text('Pulsating'),
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
                  title: const Text('Sharp'),
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
                  title: const Text('Tight'),
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
                  title: const Text('Other'),
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
            SizedBox(height: 20),
            Text('2. What was the severity:', style: TextStyle(color: const Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
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
            SizedBox(height: 20),
            Text('3. What was the headache accompanied by:', style: TextStyle(color: const Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CheckboxListTile(
                  title: const Text('Neck pain', style: TextStyle(color: const Color(0xFF16666B))),
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
                  title: const Text('Nausea', style: TextStyle(color: const Color(0xFF16666B))),
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
                  title: const Text('Vomiting', style: TextStyle(color: const Color(0xFF16666B))),
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
                  title: const Text('Visual disturbances', style: TextStyle(color: const Color(0xFF16666B))),
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
            SizedBox(height: 20),
            Text('4. Any symptoms before the headache:', style: TextStyle(color: const Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CheckboxListTile(
                  title: const Text('Visual flickering lights', style: TextStyle(color: const Color(0xFF16666B))),
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
                  title: const Text('Colored lights', style: TextStyle(color: const Color(0xFF16666B))),
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
                  title: const Text('Tunnel-like vision', style: TextStyle(color: const Color(0xFF16666B))),
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
            SizedBox(height: 20),
            Text('5. Is the headache triggered by:', style: TextStyle(color: const Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CheckboxListTile(
                  title: const Text('Cold drinks', style: TextStyle(color: const Color(0xFF16666B))),
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
                  title: const Text('Tea', style: TextStyle(color: const Color(0xFF16666B))),
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
                  title: const Text('Coffee', style: TextStyle(color: const Color(0xFF16666B))),
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
                  title: const Text('Strong smells', style: TextStyle(color: const Color(0xFF16666B))),
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
                  title: const Text('Traveling', style: TextStyle(color: const Color(0xFF16666B))),
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
                  title: const Text('Mobile phone usage', style: TextStyle(color: const Color(0xFF16666B))),
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
                  title: const Text('Allergy', style: TextStyle(color: const Color(0xFF16666B))),
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
                  title: const Text('Excess/lack of sleep', style: TextStyle(color: const Color(0xFF16666B))),
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
                  title: const Text('Not sure', style: TextStyle(color: const Color(0xFF16666B))),
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
            SizedBox(height: 20),
            Text('6. Did the headache cause you to avoid routine activities:', style: TextStyle(color: const Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
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
                Text('Yes', style: TextStyle(color: const Color(0xFF16666B))),
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
                Text('No', style: TextStyle(color: const Color(0xFF16666B))),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NoPage()),
                );
              },
              child: Text('Next', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF16666B)),
            ),
          ],
        ),
      ),
    );
  }
}


class NoPage extends StatefulWidget {
  @override
  _NoPageState createState() => _NoPageState();
}

class _NoPageState extends State<NoPage> {
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
            Text('Did you miss meals?', style: TextStyle(color: const Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
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
                Text('Yes', style: TextStyle(color: const Color(0xFF16666B))),
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
                Text('No', style: TextStyle(color: const Color(0xFF16666B))),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Glasses of Water:', style: TextStyle(color: const Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
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
                Text('Glasses: ${_glassesOfWater.toInt()}', style: TextStyle(color: const Color(0xFF16666B))),
              ],
            ),
            SizedBox(height: 20),
            Text('Did you exercise today?', style: TextStyle(color: const Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
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
                Text('Yes', style: TextStyle(color: const Color(0xFF16666B))),
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
                Text('No', style: TextStyle(color: const Color(0xFF16666B))),
              ],
            ),
            SizedBox(height: 20),
            Text('Are you facing any obstacles in being productive?', style: TextStyle(color: const Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
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
                Text('Yes', style: TextStyle(color: const Color(0xFF16666B))),
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
                Text('No', style: TextStyle(color: const Color(0xFF16666B))),
              ],
            ),
            SizedBox(height: 20),
            Text('How much sleep did you get?', style: TextStyle(color: const Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
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
            SizedBox(height: 20),
            Text('For how long did you exercise? (in hours/minutes)', style: TextStyle(color: const Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              onChanged: (value) {
                setState(() {
                  _exerciseDuration = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter exercise duration',
                hintStyle: TextStyle(color: const Color(0xFF16666B)),
              ),
            ),
            SizedBox(height: 20),
            Text('How long do you work on mobile phones or computers? (in hours)', style: TextStyle(color: const Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              onChanged: (value) {
                setState(() {
                  _screenTime = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter screen time',
                hintStyle: TextStyle(color: const Color(0xFF16666B)),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Submit form
                // Code for form submission goes here
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
