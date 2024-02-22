import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neurooooo/home.dart';

class DiaryPage extends StatefulWidget {
  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  bool? _didMissMeals;
  double _glassesOfWater = 0;
  bool? _didExerciseToday;
  bool? _productiveObstacles;

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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubmissionConfirmationPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16666B),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: Text('Submit'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF16666B),
        title: Text('Submission Confirmation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Today's response recorded!",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF16666B),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16666B),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: Text('Go back to the home page'),
            ),
          ],
        ),
      ),
    );
  }
}
