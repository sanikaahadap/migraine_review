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
            TextField(
              onChanged: (value) {
                setState(() {
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter exercise duration',
                hintStyle: TextStyle(color: Color(0xFF16666B)),
              ),
            ),
            const SizedBox(height: 20),
            const Text('How long do you work on mobile phones or computers? (in hours)', style: TextStyle(color: Color(0xFF16666B), fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              onChanged: (value) {
                setState(() {
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter screen time',
                hintStyle: TextStyle(color: Color(0xFF16666B)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {

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
