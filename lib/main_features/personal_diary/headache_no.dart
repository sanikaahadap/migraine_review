import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:neurooooo/user_home/nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoPage extends StatefulWidget {
  const NoPage({super.key});

  @override
  NoPageState createState() => NoPageState();
}

class NoPageState extends State<NoPage> {
  String? _missedMeals;
  double _glassesOfWater = 1;
  bool? _didExerciseToday;
  bool? _productiveObstacles;
  String? _sleepDuration;
  String? _exerciseDuration;
  String? _screenTime;
  Color borderBlueColor = const Color(0xFF16666B);
  late DateTime currentBackPressTime;

  @override
  void initState() {
    super.initState();
    currentBackPressTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF16666B),
      ),
      body: PopScope(
        canPop: false,
        child: SingleChildScrollView(
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
                    max: 9,
                    divisions: 9,
                    label: _glassesOfWater.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _glassesOfWater = value;
                      });
                    },
                    activeColor: const Color(0xFF16666B),
                  ),
                  const SizedBox(height: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(10, (index) {
                      return Icon(
                        Icons.local_drink,
                        color: index <= _glassesOfWater ? const Color(0xFF16666B) : Colors.grey,
                        size: 25,
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      '${_glassesOfWater.toInt()+1} glasses',
                      style: const TextStyle(color: Color(0xFF16666B)),
                    ),
                  ),
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
              const SizedBox(height: 7),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: borderBlueColor, // Use the custom color for the border
                    width: 1.0, // Choose the border width
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Optional: Add border radius for rounded corners
                ),
                child: DropdownButton<String>(
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
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              const Text('For how long did you exercise? (in hours/minutes)', style: TextStyle(color: Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 7),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: borderBlueColor, // Use the custom color for the border
                    width: 1.0, // Choose the border width
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Optional: Add border radius for rounded corners
                ),
                child: DropdownButton<String>(
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
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),
              const Text('How long do you work on mobile phones or computers? (in hours)', style: TextStyle(color: Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 7),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: borderBlueColor, // Use the custom color for the border
                    width: 1.0, // Choose the border width
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Optional: Add border radius for rounded corners
                ),
                child: DropdownButton<String>(
                  value: _screenTime,
                  onChanged: (String? value) {
                    setState(() {
                      _screenTime = value;
                    });
                  },
                  items: <String>[
                    'Less than 1 hour',
                    '1-3 hours',
                    '3-5 hours',
                    '5-7 hours',
                    'More than 7 hours',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF16666B),
                  ),
                  onPressed: () async {
                    final currentUser = FirebaseAuth.instance.currentUser;
                    if (currentUser != null) {
                      final uid = currentUser.uid;
                      await FirebaseFirestore.instance.collection('no_headache_entries').add({
                        'uid': uid,
                        'missedMeals': _missedMeals,
                        'glassesOfWater': _glassesOfWater.toInt(),
                        'didExerciseToday': _didExerciseToday,
                        'productiveObstacles': _productiveObstacles,
                        'sleepDuration': _sleepDuration,
                        'exerciseDuration': _exerciseDuration,
                        'screenTime': _screenTime,
                        'timestamp': Timestamp.now(),
                      });
                      log('Submitted');
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Log Added'),
                            content: const Text('Your log has been added successfully.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) => const CustomBottomNavigationBar()),
                                  );
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Submit',style: TextStyle(color:Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
