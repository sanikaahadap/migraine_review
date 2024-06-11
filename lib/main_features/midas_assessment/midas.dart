import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:neurooooo/user_home/nav_bar.dart';
import 'dart:async';
import 'package:neurooooo/user_home/midas_notifs.dart';

class MIDASAssessmentPage extends StatefulWidget {
  const MIDASAssessmentPage({Key? key}) : super(key: key);

  @override
  MIDASAssessmentPageState createState() => MIDASAssessmentPageState();
}

class MIDASAssessmentPageState extends State<MIDASAssessmentPage> {
  bool _canFillQuestionnaire =
      true; // Indicates whether the user can fill the questionnaire
  final String _uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _checkQuestionnaireStatus();
  }

  Future<void> _checkQuestionnaireStatus() async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (userDoc.exists) {
      Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
      Timestamp? lastFilledTimestamp =
          data?['lastMIDASFilledTimestamp'] as Timestamp?;
      if (lastFilledTimestamp != null) {
        DateTime threeMonthsAgo =
            DateTime.now().subtract(const Duration(days: 179));
        DateTime lastFilledDateTime = lastFilledTimestamp.toDate();
        if (lastFilledDateTime.isAfter(threeMonthsAgo)) {
          setState(() {
            _canFillQuestionnaire = false;
          });
        }
      }
    }
  }

  Future<void> _setQuestionnaireFilled() async {
    Timestamp now = Timestamp.now();
    await FirebaseFirestore.instance.collection('users').doc(_uid).set({
      'lastMIDASFilledTimestamp': now,
    }, SetOptions(merge: true));

    // Schedule the notification for 179 days later at 7 PM
    await LocalNotifications.scheduleDailyNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MIDAS Assessment',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF16666B),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'MIDAS Assessment',
              style: TextStyle(
                color: Color(0xFF16666B),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _canFillQuestionnaire
                  ? () {
                      _setQuestionnaireFilled().then((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MIDASQuestions()),
                        );
                      });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16666B), // Background color
                foregroundColor: Colors.white, // Text color
              ),
              child: Text(
                _canFillQuestionnaire
                    ? 'Proceed to the Questionnaire'
                    : 'Questionnaire already filled',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MIDASQuestions extends StatefulWidget {
  const MIDASQuestions({Key? key}) : super(key: key);

  @override
  MIDASQuestionsState createState() => MIDASQuestionsState();
}

class MIDASQuestionsState extends State<MIDASQuestions> {
  int _currentPageIndex = 0;
  final List<String?> _selectedOptions = List.filled(5, null);

  final List<String> _questions = [
    'How many days in the last 3 months did you miss work or school because of your headaches?',
    'On how many days in the last 3 months did you not do household work or family activities because of your headaches?',
    'How many days in the last 3 months did you miss family, social, or leisure activities because of your headaches?',
    'How many days in the last 3 months have you had a headache upon awakening in the morning?',
    'How many days in the last 3 months have you felt unable to work or carry out your usual activities because of your headaches?'
  ];

  final List<String> _options = ['One', 'Two', 'Three', 'Four', 'Five or more'];

  void _selectOption(int index, String option) {
    setState(() {
      _selectedOptions[index] = option;
    });
  }

  void _nextPage() {
    setState(() {
      if (_currentPageIndex < 4) {
        _currentPageIndex++;
      } else {
        // Navigate to the output page when all questions are answered
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MIDASOutputPage(calculateScore())),
        );
      }
    });
  }

  void _previousPage() {
    setState(() {
      if (_currentPageIndex > 0) {
        _currentPageIndex--;
      }
    });
  }

  IconData _getIconForOption(String option) {
    switch (option) {
      case 'One':
        return Icons.looks_one;
      case 'Two':
        return Icons.looks_two;
      case 'Three':
        return Icons.looks_3;
      case 'Four':
        return Icons.looks_4;
      case 'Five or more':
        return Icons.looks_5;
      default:
        return Icons.error; // Default icon for unrecognized options
    }
  }

  int calculateScore() {
    int score = 0;
    for (String? option in _selectedOptions) {
      switch (option) {
        case 'One':
          score += 1;
          break;
        case 'Two':
          score += 2;
          break;
        case 'Three':
          score += 3;
          break;
        case 'Four':
          score += 4;
          break;
        case 'Five or more':
          score += 5;
          break;
      }
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/midas_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 65),
                    const Text(
                      'Questionnaire',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 1,
                      height: 20,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _questions[_currentPageIndex],
                      style: const TextStyle(
                        fontSize: 17.0,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    const SizedBox(height: 95),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: List.generate(_options.length, (index) {
                        return Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width / 2.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: _selectedOptions[_currentPageIndex] ==
                                    _options[index]
                                ? const Color(0xFF16666B)
                                : Colors.white,
                            border: Border.all(
                              color: _selectedOptions[_currentPageIndex] ==
                                      _options[index]
                                  ? const Color(0xFF16666B)
                                  : Colors.black,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              _selectOption(_currentPageIndex, _options[index]);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  _selectedOptions[_currentPageIndex] ==
                                          _options[index]
                                      ? const Color(0xFF16666B)
                                      : Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _options[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        _selectedOptions[_currentPageIndex] ==
                                                _options[index]
                                            ? Colors.white
                                            : const Color(0xFF16666B),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  _getIconForOption(_options[index]),
                                  size: 30,
                                  color: _selectedOptions[_currentPageIndex] ==
                                          _options[index]
                                      ? Colors.white
                                      : const Color(0xFF16666B),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: _previousPage,
                          icon: const Icon(Icons.arrow_back),
                        ),
                        IconButton(
                          onPressed: _nextPage,
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MIDASOutputPage extends StatelessWidget {
  final int score;

  const MIDASOutputPage(this.score, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/midas_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Your MIDAS Score is:',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '$score',
                  style: const TextStyle(
                    fontSize: 60.0,
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF16666B),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Return'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
