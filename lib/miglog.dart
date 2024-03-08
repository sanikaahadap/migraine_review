import 'package:flutter/material.dart';
import 'home.dart';

class MigraineLogsPage extends StatefulWidget {
  const MigraineLogsPage({Key? key}) : super(key: key);

  @override
  _MigraineLogsPageState createState() => _MigraineLogsPageState();
}

class _MigraineLogsPageState extends State<MigraineLogsPage> {
  bool showOtherCharacterTextField = false; // Track checkbox state
  int _durationIndex = 0; // Index for duration options
  int _painSeverity = 1; // Initial pain severity
  int? _selectedLocation; // Track selected location of headache
  List<String> _selectedCharacter = []; // Track selected character of headache
  int? _selectedSeverity; // Track selected severity of headache

  final List<String> _durationOptions = [
    '15 mins', '30 mins', '1 hr', '3 hrs', '6 hrs', '12 hrs', 'More than 12 hrs'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Migraine Logs'),
        backgroundColor: const Color(0xFF16666B), // Set app bar color
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Text(
              'How long have you been having headaches? (months)',
              style: TextStyle(color: const Color(0xFF16666B), fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF16666B)), // Set border color
                borderRadius: BorderRadius.circular(8.0), // Set border radius
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter number of months',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  border: InputBorder.none, // Remove default border
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'How many headaches in a month?',
              style: TextStyle(color: const Color(0xFF16666B), fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF16666B)), // Set border color
                borderRadius: BorderRadius.circular(8.0), // Set border radius
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter number of headaches',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  border: InputBorder.none, // Remove default border
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Duration of headaches',
              style: TextStyle(color: const Color(0xFF16666B), fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            DropdownButton<int>(
              value: _durationIndex,
              onChanged: (int? newValue) {
                setState(() {
                  _durationIndex = newValue!;
                });
              },
              items: _durationOptions.map((String value) {
                return DropdownMenuItem<int>(
                  value: _durationOptions.indexOf(value),
                  child: Text(value, style: TextStyle(color: const Color(0xFF16666B))),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'Location of headache',
              style: TextStyle(color: const Color(0xFF16666B), fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            // Radio buttons for location of headache (left, right, complete)
            Column(
              children: [
                RadioListTile(
                  title: Text('Left', style: TextStyle(color: const Color(0xFF16666B))),
                  value: 0,
                  groupValue: _selectedLocation,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedLocation = value!;
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
                RadioListTile(
                  title: Text('Right', style: TextStyle(color: const Color(0xFF16666B))),
                  value: 1,
                  groupValue: _selectedLocation,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedLocation = value!;
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
                RadioListTile(
                  title: Text('Complete', style: TextStyle(color: const Color(0xFF16666B))),
                  value: 2,
                  groupValue: _selectedLocation,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedLocation = value!;
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Character of headache',
              style: TextStyle(color: const Color(0xFF16666B), fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            // Checkbox list for character of headache
            Column(
              children: [
                CheckboxListTile(
                  title: Text('Throbbing', style: TextStyle(color: const Color(0xFF16666B))),
                  value: _selectedCharacter.contains('Throbbing'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value!) {
                        _selectedCharacter.add('Throbbing');
                      } else {
                        _selectedCharacter.remove('Throbbing');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
                CheckboxListTile(
                  title: Text('Tight', style: TextStyle(color: const Color(0xFF16666B))),
                  value: _selectedCharacter.contains('Tight'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value!) {
                        _selectedCharacter.add('Tight');
                      } else {
                        _selectedCharacter.remove('Tight');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
                CheckboxListTile(
                  title: Text('Sharp', style: TextStyle(color: const Color(0xFF16666B))),
                  value: _selectedCharacter.contains('Sharp'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value!) {
                        _selectedCharacter.add('Sharp');
                      } else {
                        _selectedCharacter.remove('Sharp');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
                CheckboxListTile(
                  title: Text('Others', style: TextStyle(color: const Color(0xFF16666B))),
                  value: showOtherCharacterTextField,
                  onChanged: (bool? value) {
                    setState(() {
                      showOtherCharacterTextField = value!;
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
              ],
            ),
            if (showOtherCharacterTextField)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF16666B)), // Set border color
                  borderRadius: BorderRadius.circular(8.0), // Set border radius
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Other Character',
                    border: InputBorder.none, // Remove default border
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  ),
                ),
              ),
            SizedBox(height: 20.0),
            Text(
              'Pain Severity',
              style: TextStyle(color: const Color(0xFF16666B), fontSize: 18.0),
            ),
            Slider(
              value: _painSeverity.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (double value) {
                setState(() {
                  _painSeverity = value.toInt();
                });
              },
              activeColor: const Color(0xFF16666B), // Set active color
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('😊', style: TextStyle(fontSize: 24.0)), // Happy face emoji
                Text('😐', style: TextStyle(fontSize: 24.0)), // Neutral face emoji
                Text('😢', style: TextStyle(fontSize: 24.0)), // Crying face emoji
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Are most of your headaches',
              style: TextStyle(color: const Color(0xFF16666B), fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            // Radio buttons for severity of headaches (mild, moderate, severe)
            Column(
              children: [
                RadioListTile(
                  title: Text('Mild', style: TextStyle(color: const Color(0xFF16666B))),
                  value: 0,
                  groupValue: _selectedSeverity,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedSeverity = value!;
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
                RadioListTile(
                  title: Text('Moderate', style: TextStyle(color: const Color(0xFF16666B))),
                  value: 1,
                  groupValue: _selectedSeverity,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedSeverity = value!;
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
                RadioListTile(
                  title: Text('Severe', style: TextStyle(color: const Color(0xFF16666B))),
                  value: 2,
                  groupValue: _selectedSeverity,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedSeverity = value!;
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LogResponsePage(date: DateTime.now()), // Pass the current date
            ),
          );
        },
        icon: const Icon(Icons.save, color: Colors.white), // Set icon with white color
        label: Text('Submit', style: TextStyle(color: Colors.white)), // Set label with white color
        backgroundColor: const Color(0xFF16666B), // Set button background color
      ),
    );
  }
}

class LogResponsePage extends StatelessWidget {
  final DateTime date;

  const LogResponsePage({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Response Recorded'),
        backgroundColor: const Color(0xFF16666B), // Set app bar color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Response recorded on',
              style: TextStyle(color: const Color(0xFF16666B), fontSize: 18.0),
            ),
            Text(
              '${date.day}/${date.month}/${date.year}',
              style: TextStyle(color: const Color(0xFF16666B), fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: Text('Back to Home', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16666B), // Set button background color
              ),
            ),
          ],
        ),
      ),
    );
  }
}