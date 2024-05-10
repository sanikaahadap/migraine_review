import "package:flutter/material.dart";
import "package:neurooooo/ehr.dart";
import "package:neurooooo/ehr_record.dart";

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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PDFUploader()),
                );
              },
              child: const Text('upload pdf'),
            ),
          ],
        ),
      ),
    );
  }
}
