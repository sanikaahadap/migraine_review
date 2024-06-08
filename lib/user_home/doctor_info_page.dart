import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorInfoPage extends StatelessWidget {
  const DoctorInfoPage({super.key});

  // Function to launch URL
  void _launchURL() async {
    const url = 'http://drbindumenon.com/';
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Know Your Doctor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Doctor's Photo
            const Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/doctor_photo.jpg'),
              ),
            ),
            const SizedBox(height: 8),
            // Doctor's Name
            const Text(
              'Dr. Bindu Menon',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Doctor's field of study
            const Text(
              'Neurologist',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 4),
            // Doctor's Specialty
            const Text(
              'MBBS, MD (Medicine), DM (Neuro), DNB (Neuro)',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 8),
            // Achievements Title
            const Text(
              'Awards',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(height: 4),
            // Achievements List
            Expanded(
              child: ListView(
                children: const <Widget>[
                  ListTile(
                    leading: Icon(Icons.star, color: Color(0xFF16666B)),
                    title: Text(
                      'Mridha Spirit of Neurology Humanitarian Award (2022) by American Academy of Neurology',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.star, color: Color(0xFF16666B)),
                    title: Text(
                      'A. B. Baker Teacher Recognition Award (2022) by American Academy of Neurology',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.star, color: Color(0xFF16666B)),
                    title: Text(
                      'J J Rao Oration Award (2019) by the Geriatric Society of India',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.star, color: Color(0xFF16666B)),
                    title: Text(
                      'H. C. Bajoria oration Award (2016) by Indian Epilepsy Association and Indian Epilepsy Society',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            //Contact
            const Text(
              'Email : bindu.epilepsycare@gmail.com',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            // Hyperlink
            InkWell(
              onTap: _launchURL,
              child: const Text(
                'Visit Dr. Bindu Menon\'s Official Website',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF16666B),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}