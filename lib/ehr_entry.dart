import "package:flutter/material.dart";
import "package:neurooooo/ehr.dart";
import "package:neurooooo/ehr_record.dart";

class ehrmainpg extends StatelessWidget {
  const ehrmainpg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ehrrec()),
                );
              },
              child: Text('View MIDAS records'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PDFUploader()),
                );
              },
              child: Text('upload pdf'),
            ),
          ],
        ),
      ),
    );
  }
}
