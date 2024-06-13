import 'package:flutter/material.dart';

class InstructionManualPage extends StatelessWidget {
  const InstructionManualPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instruction Manual', style: TextStyle(color:Colors.white)),
        backgroundColor: const Color(0xFF16666B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const <Widget>[
            InstructionSection(
              title: 'Main Features Usage:',
              instructions: [
                'The diary should be preferably filled once everyday to keep a track of your migraine health.',
                'Patients are advised to fill out the migraine assessment once every three months.',
                'At times of migraine episodes, patients can enter their response using the migraine logs feature.',
              ],
            ),
            InstructionSection(
              title: 'Other Instructions to Use the App:',
              instructions: [
                'Your data can be viewed using the profile button on the top right corner of the home page.',
                'Use the EHR feature to check your migraine assessment records and to upload any medical documents.',
                'The YouTube Tips feature can be used to watch migraine care videos by Dr. Bindu Menon.',
                "The FAQs will answer your doubts about migraine. If the doubts aren't addressed through the FAQs feature, you can reach out to Dr. Bindu Menon at xyz@email.com.",
                'The side bar contains information about your doctor, features of the app, and the privacy policy.',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InstructionSection extends StatelessWidget {
  final String title;
  final List<String> instructions;

  const InstructionSection({super.key, required this.title, required this.instructions});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF16666B),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: 8),
            ...instructions.map((instruction) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.check_circle_outline, color: Color(0xFF16666B)),
                  ),
                  Expanded(
                    child: Text(
                      instruction,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}
