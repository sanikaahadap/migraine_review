import 'package:flutter/material.dart';
import 'package:neurooooo/home.dart';

class MIDASAssessmentPage extends StatefulWidget {
  @override
  _MIDASAssessmentPageState createState() => _MIDASAssessmentPageState();
}

class _MIDASAssessmentPageState extends State<MIDASAssessmentPage> {
  int _currentPageIndex = 0;
  List<String?> _selectedOptions = List.filled(5, null);

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
          MaterialPageRoute(builder: (context) => MIDASOutputPage(calculateScore())),
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
                padding: const EdgeInsets.all(20.0),
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
                    Divider( // Add a Divider widget
                      color: Colors.white, // Set the color to white
                      thickness: 1, // Set the thickness of the line
                      height: 20, // Set the height of the line
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _questions[_currentPageIndex],
                      style: const TextStyle(
                        fontSize: 17.0,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    SizedBox(height: 95),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: List.generate(_options.length, (index) {
                        return Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width / 2.2, // Adjust width to cover almost entire width
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: _selectedOptions[_currentPageIndex] == _options[index]
                                ? Color(0xFF16666B) // Selected option background color
                                : Colors.white, // Default color
                            border: Border.all(
                              color: _selectedOptions[_currentPageIndex] == _options[index]
                                  ? Color(0xFF16666B) // Selected option border color
                                  : Colors.black, // Default color
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              _selectOption(_currentPageIndex, _options[index]);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: _selectedOptions[_currentPageIndex] == _options[index]
                                  ? Colors.white // Selected option text color
                                  : Color(0xFF16666B), // Default text color
                            ),
                            child: Text(
                              _options[index],
                              style: TextStyle(fontSize: 16), // Increased text size
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _currentPageIndex == 0 ? null : _previousPage,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFF16666B),
                    ),
                    child: Text(
                      'Previous',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _nextPage,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFF16666B),
                    ),
                    child: Text(
                      _currentPageIndex == 4 ? 'Submit' : 'Next',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class MIDASOutputPage extends StatelessWidget {
  final int score;

  MIDASOutputPage(this.score);

  String getSeverityLevel(int score) {
    if (score >= 0 && score <= 5) {
      return 'Little or No Disability';
    } else if (score >= 6 && score <= 10) {
      return 'Mild Disability';
    } else if (score >= 11 && score <= 20) {
      return 'Moderate Disability';
    } else {
      return 'Severe Disability';
    }
  }

  @override
  Widget build(BuildContext context) {
    String severityLevel = getSeverityLevel(score);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [Color(0xFF16666B), Color(0xFF2193B0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Your MIDAS score is: $score',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Severity Level: $severityLevel',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),



                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF16666B),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Go back to home page',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF16666B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
