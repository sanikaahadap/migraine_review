import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
class DocUpload extends StatefulWidget {
  const DocUpload({super.key});

  @override
  State<DocUpload> createState() => _DocUploadState();
}

class _DocUploadState extends State<DocUpload> {

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> pdfData = [];

  Future<String> uploadPDF(String fileName, File file) async{
    final reference=FirebaseStorage.instance.ref().child("pdfs/$fileName.pdf");
    final uploadTask=reference.putFile(file);
    await uploadTask.whenComplete(() {});
    final downloadLink=await reference.getDownloadURL();
    return downloadLink;
  }

  void pickFile() async{
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
        allowedExtensions: ['pdf']
    );
    if (pickedFile != null)
      {
        String fileName = pickedFile.files[0].name;
        File file = File(pickedFile.files[0].path!);
        final downloadLink = await uploadPDF(fileName, file);

        await FirebaseFirestore.instance.collection('docs').add({
          'uid' : FirebaseAuth.instance.currentUser!.uid,
          'pdf_name': fileName,
          'download_url': downloadLink,
          'timestamp': FieldValue.serverTimestamp(),
        });
        print("PDF Uploaded successfully");

      }
  }

  void getAllPdf() async {
    final results = await _firebaseFirestore.collection("docs").get();
    pdfData = results.docs.map((e) => e.data()).toList();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllPdf();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Documents"),
      ),
      body: GridView.builder(
          itemCount: pdfData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context)=>
                      PDFViewerScreen(pdfurl: pdfData[index]['download_url'])));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/pdf.png",
                        height: 120,
                        width: 100,
                      ),
                      Text(
                        pdfData[index]['pdf_name'],
                      style: TextStyle(fontSize: 10),),
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: pickFile,
        child: Icon(Icons.upload_file),
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

  void initialisePdf() async{
    document = await PDFDocument.fromURL(widget.pdfurl);
    setState(() {});
  }
  @override

  void initState(){
    super.initState();
    initialisePdf();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body:document != null? PDFViewer(document: document!,)
          : Center(child: CircularProgressIndicator(),)
    );
  }
}