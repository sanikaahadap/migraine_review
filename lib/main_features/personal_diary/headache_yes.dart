import 'package:flutter/material.dart';
import 'headache_no.dart';
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NoPage()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF16666B)),
              child: const Text('Next', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}