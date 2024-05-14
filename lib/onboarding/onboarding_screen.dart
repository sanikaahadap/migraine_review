import 'package:flutter/material.dart';
import 'package:neurooooo/intro_screens/intro_page_1.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:neurooooo/intro_screens/intro_page_2.dart';
import 'package:neurooooo/intro_screens/intro_page_3.dart';
import 'package:neurooooo/intro_screens/intro_page_4.dart';
import 'package:neurooooo/intro_screens/intro_page_5.dart';

class OnBoardingScreen extends StatefulWidget{
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  OnBoardingScreenState createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {

  //controller to keep track of which page we're on
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
              IntroPage4(),
              IntroPage5(),
            ],
          ),
          //dot indicator
          Container(
              alignment: const Alignment(0,0.75),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [

                  SmoothPageIndicator(
                      controller: _controller,
                      count: 5,
                      effect: const WormEffect(
                        dotWidth: 10.0, // Set the width of the dots
                        dotHeight: 10.0, // Set the height of the dots
                        )
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}