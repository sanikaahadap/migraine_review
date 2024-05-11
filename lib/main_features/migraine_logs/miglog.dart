import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:neurooooo/user_home/home.dart';

class MigraineLogsPage extends StatefulWidget {
  const MigraineLogsPage({Key? key}) : super(key: key);

  @override
  MigraineLogsPageState createState() => MigraineLogsPageState();
}

class MigraineLogsPageState extends State<MigraineLogsPage> {
  bool showOtherCharacterTextField = false; // Track checkbox state
  int _durationIndex = 0; // Index for duration options
  int _painSeverity = 1; // Initial pain severity
  int? _selectedLocation; // Track selected location of headache
  final List<String> _selectedCharacter = []; // Track selected character of headache
  int? _selectedSeverity; // Track selected severity of headache
  bool _difficultyInWork = false; // Track difficulty in work
  bool _nausea = false; // Track nausea
  bool _vomiting = false; // Track vomiting
  bool _photophobia = false; // Track photophobia
  bool _phonophobia = false; // Track phonophobia
  bool _osmophobia = false; // Track osmophobia
  bool _blurringOfVision = false; // Track blurring of vision
  bool _ctMriScan = false; // Track CT/MRI scan
  int _painKillersPerMonth = 0; // Track pain killers per month
  final int _monthsOfPainkillerUse = 0; // Track months of painkiller use

  final List<String> _durationOptions = [
    '15 mins',
    '30 mins',
    '1 hr',
    '3 hrs',
    '6 hrs',
    '12 hrs',
    'More than 12 hrs'
  ];

  Future<void> _submitMigraineLog() async {
    // Create a map with the values to be stored
    Map<String, dynamic> migraineLog = {
      'durationIndex': _durationIndex,
      'painSeverity': _painSeverity,
      'selectedLocation': _selectedLocation,
      'selectedCharacter': _selectedCharacter,
      'selectedSeverity': _selectedSeverity,
      'difficultyInWork': _difficultyInWork,
      'nausea': _nausea,
      'vomiting': _vomiting,
      'photophobia': _photophobia,
      'phonophobia': _phonophobia,
      'osmophobia': _osmophobia,
      'blurringOfVision': _blurringOfVision,
      'ctMriScan': _ctMriScan,
      'painKillersPerMonth': _painKillersPerMonth,
      'monthsOfPainkillerUse': _monthsOfPainkillerUse,
      'timestamp': DateTime.now(),
    };

    try {
      // Add the data to the Firestore collection 'migraine_logs'
      await FirebaseFirestore.instance
          .collection('migraine_logs')
          .add(migraineLog);

      // Navigate to the log response page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LogResponsePage(date: DateTime.now()),
        ),
      );
    } catch (e) {
      // Handle errors here
      print('Error adding migraine log: $e');
    }
  }

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
            const SizedBox(height: 20.0),
            const Text(
              'How long have you been having headaches? (months)',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color(0xFF16666B)), // Set border color
                borderRadius: BorderRadius.circular(8.0), // Set border radius
              ),
              child: const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter number of months',
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  border: InputBorder.none, // Remove default border
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'How many headaches in a month?',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color(0xFF16666B)), // Set border color
                borderRadius: BorderRadius.circular(8.0), // Set border radius
              ),
              child: const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter number of headaches',
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  border: InputBorder.none, // Remove default border
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Duration of headaches',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
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
                  child: Text(value,
                      style: const TextStyle(color: Color(0xFF16666B))),
                );
              }).toList(),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Location of headache',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            // Radio buttons for location of headache (left, right, complete)
            Column(
              children: [
                RadioListTile(
                  title: const Text('Left',
                      style: TextStyle(color: Color(0xFF16666B))),
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
                  title: const Text('Right',
                      style: TextStyle(color: Color(0xFF16666B))),
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
                  title: const Text('Complete',
                      style: TextStyle(color: Color(0xFF16666B))),
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
            const SizedBox(height: 20.0),
            const Text(
              'Character of headache',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            // Checkbox list for character of headache
            Column(
              children: [
                CheckboxListTile(
                  title: const Text('Throbbing',
                      style: TextStyle(color: Color(0xFF16666B))),
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
                  title: const Text('Tight',
                      style: TextStyle(color: Color(0xFF16666B))),
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
                  title: const Text('Sharp',
                      style: TextStyle(color: Color(0xFF16666B))),
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
                  title: const Text('Others',
                      style: TextStyle(color: Color(0xFF16666B))),
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
                  border: Border.all(
                      color: const Color(0xFF16666B)), // Set border color
                  borderRadius: BorderRadius.circular(8.0), // Set border radius
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: 'Other Character',
                    border: InputBorder.none, // Remove default border
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  ),
                ),
              ),
            const SizedBox(height: 20.0),
            const Text(
              'Pain Severity',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('😊',
                    style: TextStyle(fontSize: 24.0)), // Happy face emoji
                Text('😐',
                    style: TextStyle(fontSize: 24.0)), // Neutral face emoji
                Text('😢',
                    style: TextStyle(fontSize: 24.0)), // Crying face emoji
              ],
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Are most of your headaches',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            // Radio buttons for severity of headaches (mild, moderate, severe)
            Column(
              children: [
                RadioListTile(
                  title: const Text('Mild',
                      style: TextStyle(color: Color(0xFF16666B))),
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
                  title: const Text('Moderate',
                      style: TextStyle(color: Color(0xFF16666B))),
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
                  title: const Text('Severe',
                      style: TextStyle(color: Color(0xFF16666B))),
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

            const SizedBox(height: 20.0),
            const Text(
              'Do you find difficulty in continuing your work when you have these headaches?',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            // Radio buttons for difficulty in work (Yes or No)
            Column(
              children: [
                RadioListTile(
                  title: const Text('Yes',
                      style: TextStyle(color: Color(0xFF16666B))),
                  value: true,
                  groupValue: _difficultyInWork,
                  onChanged: (bool? value) {
                    setState(() {
                      _difficultyInWork = value!;
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
                RadioListTile(
                  title: const Text('No',
                      style: TextStyle(color: Color(0xFF16666B))),
                  value: false,
                  groupValue: _difficultyInWork,
                  onChanged: (bool? value) {
                    setState(() {
                      _difficultyInWork = value!;
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Text(
              'During headache, do you have:',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            // Checkbox list for symptoms during headache
            Column(
              children: [
                CheckboxListTile(
                  title: const Text('Nausea',
                      style: TextStyle(color: Color(0xFF16666B))),
                  value: _nausea,
                  onChanged: (bool? value) {
                    setState(() {
                      _nausea = value!;
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
                CheckboxListTile(
                  title: const Text('Vomiting',
                      style: TextStyle(color: Color(0xFF16666B))),
                  value: _vomiting,
                  onChanged: (bool? value) {
                    setState(() {
                      _vomiting = value!;
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
                CheckboxListTile(
                  title: const Text('Photophobia',
                      style: TextStyle(color: Color(0xFF16666B))),
                  value: _photophobia,
                  onChanged: (bool? value) {
                    setState(() {
                      _photophobia = value!;
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
                CheckboxListTile(
                  title: const Text('Phonophobia',
                      style: TextStyle(color: Color(0xFF16666B))),
                  value: _phonophobia,
                  onChanged: (bool? value) {
                    setState(() {
                      _phonophobia = value!;
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
                CheckboxListTile(
                  title: const Text('Osmophobia',
                      style: TextStyle(color: Color(0xFF16666B))),
                  value: _osmophobia,
                  onChanged: (bool? value) {
                    setState(() {
                      _osmophobia = value!;
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Before headache, do you have blurring of vision during or after the headache?',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            // Radio buttons for blurring of vision (Yes or No)
            Column(
              children: [
                RadioListTile(
                  title: const Text('Yes',
                      style: TextStyle(color: Color(0xFF16666B))),
                  value: true,
                  groupValue: _blurringOfVision,
                  onChanged: (bool? value) {
                    setState(() {
                      _blurringOfVision = value!;
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
                RadioListTile(
                  title: const Text('No',
                      style: TextStyle(color: Color(0xFF16666B))),
                  value: false,
                  groupValue: _blurringOfVision,
                  onChanged: (bool? value) {
                    setState(() {
                      _blurringOfVision = value!;
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Have you done CT scan or MRI scan?',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            // Radio buttons for CT/MRI scan (Yes or No)
            Column(
              children: [
                RadioListTile(
                  title: const Text('Yes',
                      style: TextStyle(color: Color(0xFF16666B))),
                  value: true,
                  groupValue: _ctMriScan,
                  onChanged: (bool? value) {
                    setState(() {
                      _ctMriScan = value!;
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
                RadioListTile(
                  title: const Text('No',
                      style: TextStyle(color: Color(0xFF16666B))),
                  value: false,
                  groupValue: _ctMriScan,
                  onChanged: (bool? value) {
                    setState(() {
                      _ctMriScan = value!;
                    });
                  },
                  activeColor: const Color(0xFF16666B), // Set active color
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Text(
              'How many pain killers do you take in a month?',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            // Text field for number of pain killers per month
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color(0xFF16666B)), // Set border color
                borderRadius: BorderRadius.circular(8.0), // Set border radius
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _painKillersPerMonth = int.tryParse(value) ?? 0;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter number of pain killers',
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  border: InputBorder.none, // Remove default border
                ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _submitMigraineLog,
        icon: const Icon(Icons.save,
            color: Colors.white), // Set icon with white color
        label: const Text('Submit',
            style:
            TextStyle(color: Colors.white)), // Set label with white color
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
            const Text(
              'Response recorded on',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            Text(
              '${date.day}/${date.month}/${date.year}',
              style: const TextStyle(
                  color: Color(0xFF16666B),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFF16666B), // Set button background color
              ),
              child: const Text('Back to Home',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}