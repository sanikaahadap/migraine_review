import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neurooooo/user_home/nav_bar.dart';

class MigraineLogsPage extends StatefulWidget {
  const MigraineLogsPage({Key? key}) : super(key: key);

  @override
  MigraineLogsPageState createState() => MigraineLogsPageState();
}

class MigraineLogsPageState extends State<MigraineLogsPage> {
  String? _durationOption;
  int _painSeverity = 1;
  String? _selectedLocation;
  final List<String> _selectedCharacter = [];
  bool _difficultyInWork = false;
  bool _nausea = false;
  bool _vomiting = false;
  bool _photophobia = false;
  bool _phonophobia = false;
  bool _osmophobia = false;
  bool _blurringOfVision = false;
  bool _ctMriScan = false;
  int? _painKillersPerMonth;
  int? _monthsOfPainkillerUse;

  final List<String> _durationOptions = [
    '15 mins',
    '30 mins',
    '1 hr',
    '3 hrs',
    '6 hrs',
    '12 hrs',
    'More than 12 hrs'
  ];

  void _submitMigraineLog() async {
    // Create a map with the values to be stored
    Map<String, dynamic> migraineLog = {
      'durationOption': _durationOption,
      'painSeverity': _painSeverity,
      'selectedLocation': _selectedLocation ?? '',
      'selectedCharacter': _selectedCharacter,
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
      'uid': FirebaseAuth.instance.currentUser!.uid,
    };

    try {
      // Add the data to the Firestore collection 'migraine_logs'
      await FirebaseFirestore.instance
          .collection('migraine_logs')
          .add(migraineLog);

      // Show confirmation dialog
      _showConfirmationDialog();
    } catch (e) {
      // Handle errors here
      log('Error adding migraine log: $e');
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Submitted'),
          content: const Text('Your migraine log has been successfully submitted.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomBottomNavigationBar(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Migraine Logs'),
        backgroundColor: const Color(0xFF16666B),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20.0),
            const Text(
              'How long have you been having headaches? (months)',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF16666B)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter number of months',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  border: InputBorder.none,
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
                border: Border.all(color: const Color(0xFF16666B)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter number of headaches',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Duration of headaches',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF16666B)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: DropdownButton<String>(
                value: _durationOption,
                onChanged: (String? newValue) {
                  setState(() {
                    _durationOption = newValue;
                  });
                },
                items: _durationOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(color: Color(0xFF16666B))),
                  );
                }).toList(),
                isExpanded: true,
                underline: Container(
                  height: 0,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Location of headache',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Column(
              children: [
                RadioListTile(
                  title: const Text('Left', style: TextStyle(color: Color(0xFF16666B))),
                  value: 'Left',
                  groupValue: _selectedLocation,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedLocation = value;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                RadioListTile(
                  title: const Text('Right', style: TextStyle(color: Color(0xFF16666B))),
                  value: 'Right',
                  groupValue: _selectedLocation,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedLocation = value;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                RadioListTile(
                  title: const Text('Complete', style: TextStyle(color: Color(0xFF16666B))),
                  value: 'Complete',
                  groupValue: _selectedLocation,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedLocation = value;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Character of headache',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Column(
              children: [
                CheckboxListTile(
                  title: const Text('Throbbing', style: TextStyle(color: Color(0xFF16666B))),
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
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Pulsating', style: TextStyle(color: Color(0xFF16666B))),
                  value: _selectedCharacter.contains('Pulsating'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value!) {
                        _selectedCharacter.add('Pulsating');
                      } else {
                        _selectedCharacter.remove('Pulsating');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Sharp', style: TextStyle(color: Color(0xFF16666B))),
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
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Dull', style: TextStyle(color: Color(0xFF16666B))),
                  value: _selectedCharacter.contains('Dull'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value!) {
                        _selectedCharacter.add('Dull');
                      } else {
                        _selectedCharacter.remove('Dull');
                      }
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Severity of headache',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
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
              activeColor: const Color(0xFF16666B),
              label: 'Pain Severity: $_painSeverity',
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Other Symptoms',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Column(
              children: [
                CheckboxListTile(
                  title: const Text('Difficulty in work', style: TextStyle(color: Color(0xFF16666B))),
                  value: _difficultyInWork,
                  onChanged: (bool? value) {
                    setState(() {
                      _difficultyInWork = value ?? false;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Nausea', style: TextStyle(color: Color(0xFF16666B))),
                  value: _nausea,
                  onChanged: (bool? value) {
                    setState(() {
                      _nausea = value ?? false;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Vomiting', style: TextStyle(color: Color(0xFF16666B))),
                  value: _vomiting,
                  onChanged: (bool? value) {
                    setState(() {
                      _vomiting = value ?? false;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Photophobia', style: TextStyle(color: Color(0xFF16666B))),
                  value: _photophobia,
                  onChanged: (bool? value) {
                    setState(() {
                      _photophobia = value ?? false;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Phonophobia', style: TextStyle(color: Color(0xFF16666B))),
                  value: _phonophobia,
                  onChanged: (bool? value) {
                    setState(() {
                      _phonophobia = value ?? false;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Osmophobia', style: TextStyle(color: Color(0xFF16666B))),
                  value: _osmophobia,
                  onChanged: (bool? value) {
                    setState(() {
                      _osmophobia = value ?? false;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
                ),
                CheckboxListTile(
                  title: const Text('Blurring of Vision', style: TextStyle(color: Color(0xFF16666B))),
                  value: _blurringOfVision,
                  onChanged: (bool? value) {
                    setState(() {
                      _blurringOfVision = value ?? false;
                    });
                  },
                  activeColor: const Color(0xFF16666B),
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
              'Painkillers per month',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF16666B)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter number of painkillers',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Months of Painkiller Use',
              style: TextStyle(color: Color(0xFF16666B), fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF16666B)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter number of months',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20.0),

            ElevatedButton(
              onPressed: _submitMigraineLog,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16666B),
                textStyle: const TextStyle(color: Colors.white),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
