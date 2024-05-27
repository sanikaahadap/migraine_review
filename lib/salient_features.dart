import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SalientFeaturesPage extends StatelessWidget {
  final List<Map<String, String>> features = [
    {
      'title': 'Track And Assess',
      'description':
      'Understand your migraine patterns by regularly checking in. This helps tailor your care for better results.',
      'image': 'assets/intro_images/intro_1.png'
    },
    {
      'title': 'Tailored Lifestyle Tips',
      'description':
      'Curated advice, custom-fit for your lifestyle, empowering you to conquer migraines with practical, personalized guidance.',
      'image': 'assets/intro_images/intro_2.png'
    },
    {
      'title': 'Personalized Reminders',
      'description':
      'Get custom reminders to stay on course with your goals and lifestyle. They match your needs and symptom checks.',
      'image': 'assets/intro_images/intro_3.png'
    },
    {
      'title': 'Your Diary',
      'description':
      'Your dedicated space to log and track episodes, creating a comprehensive picture to better navigate your journey.',
      'image': 'assets/intro_images/intro_4.png'
    },
    {
      'title': 'FAQs',
      'description':
      'Your personal ally, ready to understand and assist in managing your migraine journey, 24/7.',
      'image': 'assets/intro_images/intro_5.png'
    },
  ];

  SalientFeaturesPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salient Features'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CarouselSlider.builder(
          itemCount: features.length,
          itemBuilder: (context, index, realIndex) {
            final feature = features[index];
            return FeatureCard(
              title: feature['title']!,
              description: feature['description']!,
              imagePath: feature['image']!,
            );
          },
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.7,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const FeatureCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain, // Adjusted BoxFit property
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

