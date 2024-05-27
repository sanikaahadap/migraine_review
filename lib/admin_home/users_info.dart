import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:neurooooo/admin_home/admin_home.dart';
import 'package:neurooooo/admin_home/user_pdf_upload.dart';
import 'package:neurooooo/admin_home/users_graph.dart';
import 'package:neurooooo/main_features/ehr/ehr_graph.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';

class UserDetailsPage extends StatelessWidget {
  final ModelUser user;

  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF16666B),
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Patient Details: ',
                style: TextStyle(
                  fontSize: 20.0, // Adjust the font size to fit the screen
                  color: Colors.white70, // Make sure the text color is visible
                ),
              ),
              TextSpan(
                text: user.name,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('Patient Details'),
          _buildDetailItem('Name', user.name, Icons.person),
          _buildDetailItem('Age', _calculateAge(user.dob), Icons.cake),
          _buildGenderDetailItem(user.uid), // Use FutureBuilder for gender

          const SizedBox(height: 20),

          _buildSectionTitle('EHR Scores'),
          _buildEhrScores(user.uid), // Display EHR scores

          const SizedBox(height: 20),

          GraphChart(uid: user.uid),

          const SizedBox(height: 20),

          _buildSectionTitle('Patient Documents'),
          _buildPatientDocuments(user.uid), // Display patient documents
        ],
      ),
    );
  }

  String _calculateAge(String dobTimestamp) {
    DateTime dob = DateTime.parse(dobTimestamp); // Parsing string to DateTime
    DateTime now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age.toString();
  }

  Future<String> _fetchGender(String uid) async {
    final docRef = FirebaseFirestore.instance.collection('user_info').doc(uid);
    final snapshot = await docRef.get();

    if (snapshot.exists) {
      final data = snapshot.data()!;
      return data['gender'] ?? 'N/A'; // Provide default value if gender is missing
    } else {
      return 'Error: User info not found';
    }
  }

  Widget _buildGenderDetailItem(String uid) {
    return FutureBuilder<String>(
      future: _fetchGender(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return _buildDetailItem('Gender', 'Error: ${snapshot.error}', Icons.wc);
        }

        return _buildDetailItem('Gender', snapshot.data ?? 'N/A', Icons.wc);
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(value.isNotEmpty ? value : 'N/A'),
      ),
    );
  }

  Widget _buildEhrScores(String uid) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('midas_scores').where('uid', isEqualTo: uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No scores available'));
        }

        List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: documents.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;

            double score = data['score']?.toDouble() ?? 0.0; // Provide a default value if score is null
            Timestamp timestamp = data['timestamp'] as Timestamp; // Ensure timestamp is cast correctly
            DateTime dateTime = timestamp.toDate();
            String formattedDate = DateFormat.yMMMd().add_jm().format(dateTime);

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.assessment, color: Colors.green),
                title: Text('MIDAS Score: $score'),
                subtitle: Text('Recorded on: $formattedDate'),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPatientDocuments(String uid) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('docs').where('uid', isEqualTo: uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No documents available'));
        }

        List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: documents.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
            String pdfName = data['pdf_name'] ?? 'Unnamed Document';
            String pdfUrl = data['download_url'] ?? '';

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
                title: Text(pdfName),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PDFViewerScreen(pdfUrl: pdfUrl),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class PDFViewerScreen extends StatefulWidget {
  final String pdfUrl;
  const PDFViewerScreen({super.key, required this.pdfUrl});

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  PDFDocument? document;

  void initialisePdf() async {
    document = await PDFDocument.fromURL(widget.pdfUrl);
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
        title: const Text('PDF Viewer'),
      ),
      body: document != null
          ? PDFViewer(document: document!)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
