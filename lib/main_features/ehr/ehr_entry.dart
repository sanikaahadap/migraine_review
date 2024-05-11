import "package:flutter/material.dart";
import "package:neurooooo/main_features/ehr/ehr.dart";
import "package:neurooooo/main_features/ehr/ehr_record.dart";
import "package:neurooooo/main_features/ehr/pdf_upload.dart";

class Ehrmainpg extends StatelessWidget {
  const Ehrmainpg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Ehrrec()),
                );
              },
              child: const Text('View MIDAS records'),
            ),
            SizedBox(height: 25,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DocUpload()),
                );
              },
              child: const Text('Upload PDFs'),
            ),
          ],
        ),
      ),
    );
  }
}
