import 'package:flutter/material.dart';
import 'package:neurooooo/slide_button.dart';

class AnimatedPage extends StatefulWidget {
  const AnimatedPage({super.key});

  @override
  AnimatedPageState createState() => AnimatedPageState();
}

class AnimatedPageState extends State<AnimatedPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Start the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image.png'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter, // Align the image to the top
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                // Content for the top half of the page
                // For example, you can place the logo and animated text here
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 190,
                      width: 190,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 0), // Adjust the spacing as needed
                    const Text(
                      'NeuroCare',
                      style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Color(0xFF16666B)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: Center(
                // Content for the bottom half of the page
                // For example, you can place the animated special shape and the button here
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     // Adjust the spacing as needed
                    SlideButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}