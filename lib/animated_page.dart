import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:neurooooo/slide_button.dart';

class AnimatedPage extends StatefulWidget {
  @override
  _AnimatedPageState createState() => _AnimatedPageState();
}

class _AnimatedPageState extends State<AnimatedPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Start the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
                      height: 200,
                      width: 200,
                    ),
                    SizedBox(height: 0), // Adjust the spacing as needed
                    AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          'NeuroCare',
                          textStyle: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF16666B), // Text color
                          ),
                          speed: Duration(milliseconds: 200),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              child: Center(
                // Content for the bottom half of the page
                // For example, you can place the animated special shape and the button here
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated special shape

                    // SlideButton with modified width, height, and font color
                    SizedBox(height: 20.0), // Adjust the spacing as needed
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