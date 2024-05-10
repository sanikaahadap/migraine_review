import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PDFUploader extends StatefulWidget {
  const PDFUploader({super.key});

  @override
  PDFUploaderState createState() => PDFUploaderState();
}

class PDFUploaderState extends State<PDFUploader> {
  List<File> _pdfFiles = [];

  @override
  void initState() {
    super.initState();
    _loadPDFFiles();
  }

  Future<void> _loadPDFFiles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? pdfPaths = prefs.getStringList('pdf_paths');
    if (pdfPaths != null) {
      setState(() {
        _pdfFiles = pdfPaths.map((path) => File(path)).toList();
      });
    }
  }

  Future<void> _savePDFFiles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> pdfPaths = _pdfFiles.map((file) => file.path).toList();
    prefs.setStringList('pdf_paths', pdfPaths);
  }

  Future pickAndUploadPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File pdf = File(result.files.single.path!);
      await _uploadPDF(pdf);
      await _savePDFFiles(); // Save the updated list of PDF files
    } else {
      print('No PDF selected.');
    }
  }

  Future<void> _uploadPDF(File pdf) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('pdfs/${DateTime.now().millisecondsSinceEpoch}.pdf');

      UploadTask uploadTask = storageReference.putFile(pdf);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {
        print('PDF uploaded');
      });

      // Get the download URL
      String downloadURL = await snapshot.ref.getDownloadURL();

      // Store the download URL in Firestore
      await FirebaseFirestore.instance.collection('ehr').add({
        'uid' : FirebaseAuth.instance.currentUser!.uid,
        'pdf_name': storageReference.name,
        'download_url': downloadURL,
        'timestamp': FieldValue.serverTimestamp(),
      });

      setState(() {
        _pdfFiles.add(pdf);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _renamePDF(int index, String newName) async {
    setState(() {
      _pdfFiles[index] = File(newName);
    });
  }

  // void _viewPDF(File pdf) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => PDFViewerPage(pdfPath: pdf.path),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Uploader'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: pickAndUploadPDF,
            child: const Text('Select and Upload PDF'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _pdfFiles.length,
              itemBuilder: (context, index) {
                File pdf = _pdfFiles[index];
                return GestureDetector(
                  onTap: () {
                    // _viewPDF(pdf);
                  },
                  child: ListTile(
                    title: Text(pdf.path.split('/').last),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'rename',
                          child: Text('Rename PDF'),
                        ),
                      ],
                      onSelected: (value) async {
                        if (value == 'rename') {
                          String? newName = await showDialog<String>(
                            context: context,
                            builder: (context) {
                              String newName = '';
                              return AlertDialog(
                                title: const Text('Rename PDF'),
                                content: TextField(
                                  onChanged: (value) {
                                    newName = value;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'New Name',
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(newName);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                          if (newName != null && newName.isNotEmpty) {
                            _renamePDF(index, newName);
                          }
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class PDFViewerPage extends StatelessWidget {
//   final String pdfPath;
//
//   const PDFViewerPage({Key? key, required this.pdfPath}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Viewer'),
//       ),
//       body: SfPdfViewer.network(pdfPath),
//     );
//   }
// }

void main( ) {
  runApp(const MaterialApp(
    home: PDFUploader( ),
  ));
}