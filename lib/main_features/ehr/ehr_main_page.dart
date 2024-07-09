import 'package:flutter/material.dart';
import 'package:neurooooo/main_features/ehr/ehr_midas_records.dart';
import 'package:neurooooo/main_features/ehr/pdf_upload.dart';
import 'migraine_logs_list.dart';

class EhrMainPage extends StatelessWidget {
  const EhrMainPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EHR (Electronic Health Records)',
            style: TextStyle(color: Colors.white,
                fontSize: 17.25),
        ),
        backgroundColor: const Color(0xFF16666B),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 90),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DocUpload()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16666B),
                padding:
                const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text('Upload Medical Reports',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EhrRecordsPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16666B),
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text('View MIDAS Records',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MigraineLogsListPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16666B),
                padding:
                const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text('View Migraine Logs',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),

          ],
        ),
      ),
    );
  }
}