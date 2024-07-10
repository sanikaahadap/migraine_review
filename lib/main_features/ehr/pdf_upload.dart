import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DocUpload extends StatefulWidget {
  const DocUpload({super.key});

  @override
  State<DocUpload> createState() => _DocUploadState();
}

class _DocUploadState extends State<DocUpload> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> pdfData = [];
  bool isLoading = false;

  Future<String> uploadPDF(String fileName, File file) async {
    final reference =
    FirebaseStorage.instance.ref().child("pdfs/$fileName.pdf");
    final uploadTask = reference.putFile(file);
    await uploadTask.whenComplete(() {});
    final downloadLink = await reference.getDownloadURL();
    return downloadLink;
  }

  void showAlert(String title, String content, {VoidCallback? onOkPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                if (onOkPressed != null) {
                  onOkPressed();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void pickFile() async {
    setState(() {
      isLoading = true;
    });

    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (pickedFile != null) {
      String fileName = pickedFile.files[0].name;
      File file = File(pickedFile.files[0].path!);

      // Check file size
      if (file.lengthSync() > 1024 * 1024) {
        showAlert("Error", "File size exceeds 1 MB limit.");
        setState(() {
          isLoading = false;
        });
        return;
      }

      final downloadLink = await uploadPDF(fileName, file);

      await FirebaseFirestore.instance.collection('docs').add({
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'pdf_name': fileName,
        'download_url': downloadLink,
        'timestamp': FieldValue.serverTimestamp(),
      });

      log("PDF Uploaded successfully");
      showAlert("Success", "PDF Uploaded successfully.");
    }

    getAllPdf();

    setState(() {
      isLoading = false;
    });
  }

  void showPreUploadAlert() {
    showAlert(
      "Attention",
      "File size shouldn't exceed 1 mb and please rename the file in the following format:\n'report type_your name'.",
      onOkPressed: pickFile,
    );
  }

  void getAllPdf() async {
    String currentUserUID = FirebaseAuth.instance.currentUser!.uid;
    final results = await _firebaseFirestore
        .collection("docs")
        .where('uid', isEqualTo: currentUserUID)
        .get();
    pdfData = results.docs.map((e) => e.data()).toList();
    // Sort by timestamp in descending order
    pdfData.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Medical Reports",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF16666B),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: getAllPdf,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : pdfData.isEmpty
          ? const Center(child: Text('No PDFs uploaded yet.'))
          : ListView.builder(
        itemCount: pdfData.length,
        itemBuilder: (context, index) {
          // Format timestamp to readable date
          DateTime uploadedDate =
          pdfData[index]['timestamp'].toDate();
          String formattedDate =
          DateFormat('dd MMM yyyy').format(uploadedDate);
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 16.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        PDFViewerScreen(
                          pdfurl: pdfData[index]['download_url'],
                        ),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/pdf.png",
                    height: 40,
                    width: 32,
                  ),
                  title: Text(
                    pdfData[index]['pdf_name'],
                    style: const TextStyle(fontSize: 14),
                  ),
                  subtitle: Text(
                    formattedDate,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showPreUploadAlert,
        backgroundColor: const Color(0xFF16666B),
        tooltip: 'Upload PDF',
        child: const Icon(
          Icons.upload_file,
          color: Colors.white,
        ),
      ),
    );
  }
}

class PDFViewerScreen extends StatefulWidget {
  final String pdfurl;
  const PDFViewerScreen({super.key, required this.pdfurl});

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  PDFDocument? document;

  void initialisePdf() async {
    document = await PDFDocument.fromURL(widget.pdfurl);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initialisePdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PDF Viewer",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF16666B),
      ),
      body: document != null
          ? PDFViewer(document: document!)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}