import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DiaryDetailsPage extends StatelessWidget {
  final String uid;

  DiaryDetailsPage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diary Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(child: _buildDiaryYes(uid)),
            const SizedBox(height: 16.0),
            Expanded(child: _buildDiaryNo(uid)),
          ],
        ),
      ),
    );
  }

  Widget _buildDiaryYes(String uid) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('headache_occurence_entries')
          .where('uid', isEqualTo: uid)
          .orderBy('timestamp', descending: true)
          .limit(5) // Limit the number of results to 5
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
              child: Text('No headache occurrence entries available'));
        }

        List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: documents.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data =
                documents[index].data() as Map<String, dynamic>;

            Timestamp timestamp = data['timestamp'] as Timestamp;
            DateTime dateTime = timestamp.toDate();
            String formattedDate = DateFormat.yMMMd().add_jm().format(dateTime);

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading:
                    const Icon(Icons.book_outlined, color: Colors.deepOrange),
                title: Text(formattedDate),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DiaryYesDetailsPage(
                        data: data,
                      ),
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

  Widget _buildDiaryNo(String uid) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('no_headache_entries')
          .where('uid', isEqualTo: uid)
          .orderBy('timestamp', descending: true)
          .limit(5) // Limit the number of results to 5
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No no-headache entries available'));
        }

        List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: documents.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data =
                documents[index].data() as Map<String, dynamic>;

            Timestamp timestamp = data['timestamp'] as Timestamp;
            DateTime dateTime = timestamp.toDate();
            String formattedDate = DateFormat.yMMMd().add_jm().format(dateTime);

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.sticky_note_2_outlined,
                    color: Colors.green),
                title: Text(formattedDate),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DiaryNoDetailsPage(
                        data: data,
                      ),
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

class DiaryYesDetailsPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DiaryYesDetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> filteredData = Map.from(data);
    filteredData.remove('uid');
    filteredData.remove('timestamp');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF16666B),
        title: const Text(
          'Headache Occurences',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: filteredData.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${entry.key}:',
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF16666B),
                              ),
                            ),
                            Text(
                              entry.value.toString(),
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'true : yes \nfalse : no \nnull : not available',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                  fontSize: 14.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DiaryNoDetailsPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DiaryNoDetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> filteredData = Map.from(data);
    filteredData.remove('uid');
    filteredData.remove('timestamp');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF16666B),
        title: const Text(
          'No Headache Experienced',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: filteredData.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${entry.key}:',
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF16666B),
                              ),
                            ),
                            Text(
                              entry.value.toString(),
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'true : yes \nfalse : no \nnull : not available',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                  fontSize: 14.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
