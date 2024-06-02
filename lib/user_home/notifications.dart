import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  AnalysisPageState createState() => AnalysisPageState();
}

class AnalysisPageState extends State<AnalysisPage> {
  Map<String, int> _triggersFrequency = {};
  Map<String, int> _symptomsFrequency = {};
  Map<String, int> _preSymptomsFrequency = {};

  @override
  void initState() {
    super.initState();
    _analyzeData();
  }

  void _analyzeData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    // Get all diary entries for the current user
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('headache_occurence_entries')
        .where('uid', isEqualTo: uid)
        .get();

    // Initialize frequency maps
    _triggersFrequency = {};
    _symptomsFrequency = {};
    _preSymptomsFrequency = {};

    // Analyze the entries
    for (var doc in querySnapshot.docs) {
      List<dynamic> triggers = doc['headacheTriggers'];
      List<dynamic> symptoms = doc['headacheAccompaniedBy'];
      List<dynamic> preSymptoms = doc['preHeadacheSymptoms'];

      for (String trigger in triggers) {
        _triggersFrequency[trigger] = (_triggersFrequency[trigger] ?? 0) + 1;
      }

      for (String symptom in symptoms) {
        _symptomsFrequency[symptom] = (_symptomsFrequency[symptom] ?? 0) + 1;
      }

      for (String preSymptom in preSymptoms) {
        _preSymptomsFrequency[preSymptom] =
            (_preSymptomsFrequency[preSymptom] ?? 0) + 1;
      }
    }

    setState(() {});
  }

  IconData _getTriggerIcon(String trigger) {
    switch (trigger) {
      case 'Cold drinks':
        return Icons.local_drink;
      case 'Tea':
        return Icons.local_cafe;
      case 'Strong smells':
        return Icons.waves;
      case 'Traveling':
        return Icons.directions_car;
      case 'Mobile phone usage':
        return Icons.phone_iphone;
      case 'Allergy':
        return Icons.healing;
      case 'Excess/lack of sleep':
        return Icons.bed;
      case 'Coffee':
        return Icons.coffee;
      default:
        return Icons.help; // default icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF16666B),
        title:
            const Text('Notifications', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Potential Headache Triggers:',
              style: TextStyle(
                color: Color(0xFF16666B),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _triggersFrequency.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                String trigger = _triggersFrequency.keys.elementAt(index);
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getTriggerIcon(trigger),
                          color: Color(0xFF16666B),
                          size: 40,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          trigger,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Color(0xFF16666B),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Common Accompanying Symptoms:',
              style: TextStyle(
                color: Color(0xFF16666B),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ..._symptomsFrequency.entries
                .map((entry) => Text(
                      entry.key,
                      style: const TextStyle(color: Color(0xFF16666B)),
                    ))
                .toList(),
            const SizedBox(height: 20),
            const Text(
              'Common Pre-headache Symptoms:',
              style: TextStyle(
                color: Color(0xFF16666B),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ..._preSymptomsFrequency.entries
                .map((entry) => Text(
                      entry.key,
                      style: const TextStyle(color: Color(0xFF16666B)),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
