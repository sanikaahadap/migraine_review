import 'package:flutter/material.dart';
import 'headache_no.dart';
import 'headache_yes.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class DiaryPage extends StatefulWidget {

  @override
  DiaryPageState createState() => DiaryPageState();
}

class DiaryPageState extends State<DiaryPage> {
  // bool? _hadHeadache;
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
        title: const Text(
          'Your Diary',
          style: TextStyle(color: Color(0xFF16666B),
          ),

        ),
        // backgroundColor: const Color(0xFF16666B),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Did you have a headache today?',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF16666B),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // setState(() {
                //   _hadHeadache = true;
                //
                // });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const YesPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16666B),
              ),
              child: const Text('Yes', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // setState(() {
                //   _hadHeadache = false;
                // });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NoPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16666B),
              ),
              child: const Text('No', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

