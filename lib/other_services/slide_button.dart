import 'package:flutter/material.dart';
import 'package:neurooooo/onboarding/features.dart';

class SlideButton extends StatefulWidget {
  const SlideButton({super.key});

  @override
  SlideButtonState createState() => SlideButtonState();
}

class SlideButtonState extends State<SlideButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: ElevatedButton(
        onPressed: () {
          // Navigate to the new page when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Features()),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
          backgroundColor: const Color(0xFF16666B),
        ),
        child: const Text(
          'Get Started',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
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