import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neurooooo/user_home/local_notifs.dart';
import 'package:neurooooo/user_home/midas_notifs.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  AnalysisPageState createState() => AnalysisPageState();
}

class AnalysisPageState extends State<AnalysisPage> {
  Map<String, int> _triggersFrequency = {};

  @override
  void initState() {
    super.initState();
    _analyzeData();
  }

  Future<void> _analyzeData() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      // Get the last three diary entries for the current user
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('headache_occurence_entries')
          .where('uid', isEqualTo: uid)
          .orderBy('timestamp', descending: true)
          .limit(3)
          .get();

      // Initialize frequency maps
      _triggersFrequency = {};

      // Analyze the entries
      for (var doc in querySnapshot.docs) {
        List<dynamic> triggers = doc['headacheTriggers'];

        for (String trigger in triggers) {
          _triggersFrequency[trigger] = (_triggersFrequency[trigger] ?? 0) + 1;
        }
      }

      // Filter triggers that occur at least twice
      _triggersFrequency.removeWhere((key, value) => value < 2);

      setState(() {});
    } catch (e) {
      print('Error analyzing data: $e');
    }
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
            _triggersFrequency.isEmpty
                ? const Center(
                    child: Text(
                      'No potential triggers found yet',
                      style: TextStyle(
                        color: Color(0xFF16666B),
                        fontSize: 16,
                      ),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _triggersFrequency.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                                color: const Color(0xFF16666B),
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
            SizedBox(
              height: 20,
            ),
            Center(child: Notifs()),
            SizedBox(
              height: 20,
            ),
            Center(child: MidasNotifs()),
          ],
        ),
      ),
    );
  }
}
